#Cron Scraper

## Prereqs
    RVM

## Use it
    bundle install
    whenever --update-crontab

## Shutdown
If you don't shut it down it will keep going and going and going .... 
    
    whenever --cron-clear

## Other thoughts
	
This generates a PStore called schedules.

##Data Format
    {
      "timestamp" => {
        "stop_id" => [{route, destination, sdt, est}....]
        "stop_id" => [{route, destination, sdt, est}....]
        "stop_id" => [{route, destination, sdt, est}....]
      }
      "timestamp" => {
        "stop_id" => [{route, destination, sdt, est}....]
        "stop_id" => [{route, destination, sdt, est}....]
        "stop_id" => [{route, destination, sdt, est}....]
      }
    }

