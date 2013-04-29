#!/usr/bin/env ruby

require 'csv'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.muni.org/departments/transit/peoplemover/Pages/default.aspx'))

agency = [{
	:id => 1,
	:agency_name => doc.css("title")[0].text.strip,
	:agency_url => "http://www.muni.org/departments/transit/peoplemover/Pages/default.aspx",
	:agency_timezone => "America/Anchorage",
	:agency_lang => "EN",
	:agency_phone => doc.css("div#MOA_SubDeptAddress li")[-1].text,
	:agency_fare_url => "http://www.muni.org/Departments/transit/PeopleMover/Pages/fareandpass.aspx",
}]

CSV.open("CSVs/agency.csv", "wb"){|csv|
  csv << ["agency_id", "agency_name", "agency_url", "agency_timezone", "agency_lang", "agency_phone", "agency_fare_url"]
  agency.each{|b|
    csv << b.values
  }
}