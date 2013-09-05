require 'rake/testtask'

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

task :gen_stop_times => "CSVs" do

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

task :gen_agency => "CSVs" do

end

task :gen_stops => "CSVs" do

end

task :gen_routes => "CSVs" do

end

task :gen_trips => "CSVs" do

end