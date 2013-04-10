#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

wheels = {:routes => [], :stop_schedules => []}
doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}

trips = []
i = 0 #This is for generating the trip id
wheels[:routes].each do |r|
	trips.push({
		:route_id => r[:id],
		:service_id => 1, #This assumes that all routes run M-F.  1 for M-F, 2 for Saturday, 3 for Sunday
		:trip_id => i, #dataset unique
	})
	i+=1
end


puts JSON.generate(trips)
File.open('trips.txt', 'w') {|f| f.write(JSON.generate(trips)) }
