#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'csv'

wheels = {:routes => [], :stop_schedules => []}
doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}

trips = []

wheels[:routes].each do |r|
  if r[:id] != "102"
    trips.push({ #All the routes have three schedules, M-F, Sa, Su.
      :route_id => r[:id],
      :service_id => 1,
      :trip_id => r[:id].to_s + "W",
    })
		trips.push({
			:route_id => r[:id],
			:service_id => 2,
			:trip_id => r[:id].to_s + "Sa",
		}) 
		trips.push({
			:route_id => r[:id],
			:service_id => 3,
			:trip_id => r[:id].to_s + "Su",
		})
	else
    trips.push({ #Except for 102 which only runs M-F
      :route_id => r[:id],
      :service_id => 1, #Route 102 only runs M-F
      :trip_id => r[:id].to_s + "W",
    })    
  end
end


CSV.open("CSVs/trips.txt", "wb"){|csv|
  csv << ["route_id", "service_id", "trip_id"]
  trips.each{|b|
    csv << b.values
  }
}