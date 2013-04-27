#!/usr/bin/env ruby

#foreign keys
#trip_id (it's the route id)
#arrival_time
#departure_time
#stop_id
#stop_sequence


require 'nokogiri'
require 'open-uri'
require 'json'

wheels = {:routes => [], :stop_schedules => []}
doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}

stops_info = []

wheels[:routes].each do |r|
  stop_info = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetRouteXml.ashx?routeNumber=#{r[:id]}"))
  schedule_info = Nokogiri::HTML(open("http://www.muni.org/Departments/transit/PeopleMover/Route%202012%20Schedules%20HTML/#{r[:id].rjust(3, '0')}.htm"))
  stops = stop_info.css('stop').map do |s|
    stop = {:id => s['html'], :name => s['label'].force_encoding('UTF-8').gsub(/[[:space:]]/, ' ').strip}
  end
  
  main_stops = schedule_info.css('table tr')[3].css('td').map {|s| s.text.force_encoding('UTF-8').gsub(/&/, 'and').gsub(/[[:space:]]/, ' ').strip }
  main_stops.each do |m|
    stops.each do |n|
      if n[:name].include? m
        stops_info.push({
          :trip_id => r[:id],
          :stop_id => n[:id],
        })
      end
    end
  end
  
end



puts JSON.generate(stops_info)
