#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

wheels = {:routes => [], :stop_schedules => []}
doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}

trips = []

wheels[:routes].each do |r|
  if r[:id] != 102
    trips.push({
      :route_id => r[:id],
      :service_id => 4, #All the routes run every day, except 102
      :trip_id => r[:id]
    })
  else
    trips.push({
      :route_id => r[:id],
      :service_id => 1, #Route 102 only runs M-F
      :trip_id => r[:id]
    })    
  end
end


puts JSON.generate(trips)
