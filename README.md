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
