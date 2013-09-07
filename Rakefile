require 'rake/testtask'
require 'nokogiri'
require 'open-uri'
require 'csv'

task :default => [:test]

Rake::TestTask.new do |t|
	t.test_files = FileList['test/*test.rb']
	t.verbose = true
	t.warning = true
end

desc 'Build the CSVs and validate them'
task :validate => [:gen_stop_times, :gen_agency, :gen_stops, :gen_routes, :gen_trips] do
	system("cd transitfeed-1.2.12/ && python feedvalidator.py ../CSVs/")
end

desc 'Build the stop times csv'
task :gen_stop_times => "CSVs" do
	require './stop_times.rb'
	wheels = {:routes => [], :stop_schedules => []}
	doc = Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx'))
	wheels[:routes] = doc.css('.routeNameListEntry').map {|l| {:id => l['routeid'], :name => l.content}}

	stop_times = []
	wheels[:routes].each{|r|
	  b = Busses.new(r[:id])
	  stop_times.push(b.read_stop_times)
	}

	CSV.open("CSVs/stop_times.txt", "wb"){|csv|
	  csv << ["trip_id", "arrival_time", "departure_time", "stop_id", "stop_sequence"]
	  stop_times.each{|b|
	    b.map{|c|
	      csv << c.values
	    }
	  }
	}

end

desc 'Build the agency csv'
task :gen_agency => "CSVs" do

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

	CSV.open("CSVs/agency.txt", "wb"){|csv|
  	csv << ["agency_id", "agency_name", "agency_url", "agency_timezone", "agency_lang", "agency_phone", "agency_fare_url"]
  	agency.each{|b|
    	csv << b.values
  	}
	}	
end

desc 'Build the stops csv'
task :gen_stops => "CSVs" do

end

desc 'Build the routes csv'
task :gen_routes => "CSVs" do

end

desc 'Build the trips csv'
task :gen_trips => "CSVs" do

end
