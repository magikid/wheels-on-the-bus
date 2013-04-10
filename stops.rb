#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

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


stops = []

wheels[:routes].each do |r|
  r[:stops].each do |s|
    stops.push({
      :stop_id => s[:id],
      :stop_name => s[:name],
      :stop_lat => s[:lat],
      :stop_lon => s[:lng],
    })
  end
end

puts JSON.generate(stops)
