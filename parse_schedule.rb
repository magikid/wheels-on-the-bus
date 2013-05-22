require 'nokogiri'
require 'open-uri'

=begin
  
TODO: Figure out how to work out M-F/Sa/Su into this.  It currently only does M-F.
  
=end

class Busses
  
  def initialize()
    @routes,@mainstops = [],{}
    Nokogiri::HTML(open('http://bustracker.muni.org/InfoPoint/noscript.aspx')).css('a.routeNameListEntry').each{|r|
      @routes.push(r['routeid'].force_encoding('UTF-8').to_i)
    }
    @routes.each{|r|
      temp_sched = []
      Nokogiri::HTML(open("http://www.muni.org/Departments/transit/PeopleMover/Route%202012%20Schedules%20HTML/#{r.to_s.rjust(3, '0')}.htm")).css('table tr')[3].css('td').map {|s|
        temp_sched.push(s.text.force_encoding('UTF-8').gsub(/&/, 'and').gsub(/[[:space:]]+/, ' ').strip)
      }
      @mainstops[r] = temp_sched
    }
  end

  def route(route_number, direction)
    schedule = Nokogiri::HTML(open("http://www.muni.org/Departments/transit/PeopleMover/Route%202012%20Schedules%20HTML/#{"1".to_s.rjust(3, '0')}.htm"))
    
    #This finds the breaks in the page that separates the weekday from Sat from Sun schedules
    separating_rows = []
    schedule.css('table tr').each_with_index{|r,index|
      if r.css('td')[0].text == "Weekday" or r.css('td')[0].text == "Saturday" or r.css('td')[0].text == "Sunday"
        separating_rows.push(index)
      end
    }

    #This makes sure that there are enough elements in the separating_rows array
    if separating_rows.length < 3
      separating_rows.push(schedule.css('table tr').length-1)
    end

    #This sets the default value for new hash keys of an array.  The loops through the mainstops to create them all.
    stop_times = Hash.new { |hash, key| hash[key] = [] }
    @mainstops[route_number].each{ |value|
      stop_times[value]
    }

    #This is the tricky bit that grabs the times for each stop.
    #Only grabs weekday times right now hence separating_rows[0] and [1], the other times are in the rest of the separating_row elements.
    Range.new(separating_rows[0]+1, separating_rows[1]-1).each{ |j|
      #Direction==0 means the left side of the schedule on the page.
      if direction==0
        0.upto((@mainstops[route_number].length/2)-1).each{ |i|
          #This grabs the time, forces UTF-8, gets rid of whitespace and junk, then formats it like 00:00:00
          stop_times[@mainstops[route_number][i]].push(schedule.css('table tr')[j].css('td')[i].text.force_encoding('UTF-8').gsub(/[[:space:]]+/, ' ').gsub(/\u2014/, '').rjust(5, '0') + ":00")
        }
      #Direction==1 means the right side of the schedule on the page.
      elsif direction==1
        num1 = nil
        num2 = nil
        (@mainstops[route_number].length/2).upto(@mainstops[route_number].length-1).each{ |i|
          #This grabs the time, forces UTF-8, gets rid of whitespace and junk, then formats it like 00:00:00
          stop_times[@mainstops[route_number][i]].push(schedule.css('table tr')[j].css('td')[i].text.force_encoding('UTF-8').gsub(/[[:space:]]+/, ' ').gsub(/\u2014/, '').rjust(5, '0') + ":00")
        }
      end
    }    

    #Since only one direction can be specified, I've got 2x as many elements in the hash.  This gets rid of the empty ones.
    return stop_times.delete_if{ |key, value| value == [] }
  end

  def isroute?(route_number)
    if @routes.include? route_number
      return true
    else
      return false
    end
  end

  def ismainstop?(stop_name, *p)
    stops_returned = []

    if p.length == 1
      if @mainstops[p[0]].include? stop_name
        stops_returned.push(p[0])
      end
    else
      @mainstops.each{|key,value|
        if value.include? stop_name
          stops_returned.push(key)
        end
      }
    end

    return stops_returned
  end
  
  def all_routes
    allroutes = {}
    @routes.each{|r|
      allroutes[r] = nil
    }

    return allroutes
  end

end

socrata_url = "http://opendata.socrata.com/resource/m9cr-ry5j.json"
