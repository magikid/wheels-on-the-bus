#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'json'

Wheels = Struct.new(:routes, :stop_schedules)
Route = Struct.new(:id, :name, :stops, :geometry, :vehicles)
Stop = Struct.new(:id, :name, :lat, :lng)
Segment = Struct.new(:lat, :lng)
Vehicle = Struct.new(:id, :lat, :lng, :data)
StopSchedule = Struct.new(:stop_id, :departures)

wheels = Wheels.new

doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))

wheels.routes = doc.css('.routeNameListEntry').map { |l| Route.new(l['routeid'], l.content) }

wheels.routes.each do |r|
  doc = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetRouteXml.ashx?routeNumber=#{r.id}"))

  r.stops = doc.css('stop').map { |s| Stop.new(s['html'], s['label'], s['lat'], s['lng']) }

  trace_url = doc.css('info').first['trace_kml_url']
  doc = Nokogiri::XML(open(trace_url))

  r.geometry = doc.css('coordinates').map do |line|
    segments = line.text.split(' ').map do |p|
      c = p.split(',')
      Segment.new(c[1], c[0])
    end
  end

  doc = Nokogiri::XML(open("http://bustracker.muni.org/InfoPoint/map/GetVehicleXml.ashx?RouteId=#{r.id}"))
  vehicles = doc.css('vehicle').map do |v|
    doc = Nokogiri::HTML(open("http://bustracker.muni.org/InfoPoint/map/GetVehicleHtml.ashx?vehicleid=#{v['name']}"))
    vehicle = Vehicle.new(v['name'], v['lat'], v['lng'])
    vehicle.data = {}
    doc.css('li').each do |l|
      kv = l.text.split(':')
      vehicle.data[kv.first.gsub(/\s+/,"_").strip.downcase.to_sym] = kv.last.strip
    end
    vehicle
  end
  r.vehicles = vehicles
end

wheels.stop_schedules = wheels.routes.map {|r| r.stops.map {|s| s.id}}.flatten.uniq.map do |s|
  doc = Nokogiri::HTML(open("http://bustracker.muni.org/InfoPoint/map/GetStopHtml.ashx?stopid=#{s}"))
  sched = StopSchedule.new(s)
  sched.departures = doc.css('.oddDepartureGroup,.evenDepartureGroup').map do |d|
    td = d.css('td')
    {:route => td[0].text, :destination => td[1].text, :sdt => td[2].text, :edt => td[3].text}
  end
  sched
end

puts wheels.to_json
