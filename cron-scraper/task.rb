require 'nokogiri'
require 'open-uri'
require 'json'
require 'pstore'

stops_store = PStore.new('stops.data')
if !File.exist?('stops.data') 
  doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
  stops = []
  routes = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid']}}
  routes.each do |r|
    doc = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetRouteXml.ashx?routeNumber=#{r[:id]}"))
    doc.css('stop').each {|s| stops << s['html']} 
  end
  stops_store.transaction do
    stops_store["stops"] = stops.uniq
  end
end

stops = nil
stops_store.transaction { stops = stops_store["stops"] }
schedules = {};
threads = []
schedules_mux = Mutex.new
stops.each do |stop_id|
  threads << Thread.new do 
    doc = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetStopHtml.ashx?vehicleId=#{stop_id}")) 
    data = doc.css('.oddDepartureGroup,.evenDepartureGroup').map do |d|
      td = d.css('td')    
      {:route => td[0].text, :destination => td[1].text, :sdt => td[2].text, :edt => td[3].text} if td[2].text != "Done"
    end

    schedules_mux.synchronize {
      schedules[stop_id] = data
    }
  end
end

threads.each(&:join)

schedules_store = PStore.new('schedules.data')
timestamp = Time.now.strftime("%d/%m/%Y %H:%M")
schedules_store.transaction { 
  schedules_store[timestamp] = schedules 
}

total = schedules.inject(0) {|sum, (key, a)| sum + a.length}
puts "#{timestamp}, #{total} stop times were collected \n\r"