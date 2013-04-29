#!/usr/share/ruby

puts "Generating stop_times.txt"
system("ruby stop_times.rb")
puts "Generating agency.txt"
system("ruby agency.rb")
puts "Generating stops.txt"
system("ruby stops.rb")
puts "Generating routes.txt"
system("ruby routes.rb")
puts "Generating trips.txt"
system("ruby trips.rb")
puts("Running feedvalidator.py")
system("cd transitfeed-1.2.12/ && python feedvalidator.py ../CSVs/")