#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'csv'

wheels = {:routes => [], :stop_schedules => []}
doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}
wheels[:routes].each do |r|
  doc = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetRouteXml.ashx?routeNumber=#{r[:id]}"))
  stops = doc.css('stop').map do |s|
    stop = {:id => s['html'], :name => s['label'], :lat => s['lat'], :lng => s['lng']}
  end
  r[:stops] = stops
  trace_url = doc.css('info').first['trace_kml_url']
  doc = Nokogiri::XML(open(trace_url))
  r[:geometry] = doc.css('coordinates').map do |line|
    segments = line.text.split(' ').map do |p|
      c = p.split(',')
      {:lat => c[1], :lng => c[0]}
    end
  end
end


routes = []

wheels[:routes].each do |r|
  routes.push({
    :route_id => r[:id],
    :route_short_name => r[:id],
    :route_long_name => r[:name],
    :route_type => 3,
  })
end

CSV.open("CSVs/routes.txt", "wb"){|csv|
  csv << ["route_id", "route_short_name", "route_long_name", "route_type"]
  routes.each{|b|
    csv << b.values
  }
}
