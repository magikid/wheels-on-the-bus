[![Build Status](https://travis-ci.org/codeforanchorage/wheels-on-the-bus.png?branch=master)](https://travis-ci.org/codeforanchorage/wheels-on-the-bus)
[![Code Climate](https://codeclimate.com/github/codeforanchorage/wheels-on-the-bus.png)](https://codeclimate.com/github/codeforanchorage/wheels-on-the-bus)

# THE WHEELS ON THE BUS

Code that scrapes the transit data on the [Anchorage People Mover website](http://bustracker.muni.org/InfoPoint/) into [GTFS format](https://developers.google.com/transit/gtfs/reference) for upload to Google Transit.  You will need both python and ruby installed for this.  If the feedvalidator.py throws an error about Time Zones, ```run easy_install pytz```

## Use it

    bundle install
    ruby generate_CSVs.rb

## Other thoughts
	
The generate_CSVs.rb file will call all of the individual ruby files and output the CSVs into the CSVs/ folder.  After that, it will call the feedvalidator.py script to validate the CSVs.  The validator script will output an HTML file (validation-results.html) into the transitfeed-1.2.12 folder.  Pull that up in a browser to see what's wrong with the CSV files.

Pull requests welcome.

## Plan

## Usage

This should be as simple as

  ruby generate_schedules.rb

That one script should handle (or at least kickoff) every other action
needed.

## Code plan
1.  Grab the route numbers, names, and timetables from
http://www.muni.org/Departments/transit/PeopleMover/Pages/Timetables.aspx
2.  In each timetable, there are two halves of the page corresponding
    with
each direction the bus goes.  Determine  the half-way point.
3.  Determine which rows deliniate the Weekday, Saturday, and Sunday
service.
4.  Create a data structure with all of the stops in it for each of the
services and each direction.
5.  Read across each row and add time to the correct stop, direction and
day.
  a.  Handle any times that the bus doesn't run.
  b.  Bold times are PM
6.  Determine overlapping stops.
7.  Each stop requires:
  a.  stop_id - unique
  b.  stop_name
  c.  stop_lat
    i. look for online service to figure this out.
  d.  stop_lon
    i. look for online service to figure this out.
8.  Each route requires:
  a.  route_id - unique
  b.  route_short_name - the bus number: 1
  c.  route_lone_name - the route name from the system page: Crosstown
  d.  route_type - This will be 3 for all of Anchorage since it only has
Busses.
9.  Each trip requires:
  a.  route_id - from routes
  b.  service_id - unique, used in calendar
  c.  trip_id - unique

To be continued with stop times
