require 'nokogiri'
require 'open-uri'

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

  def route(route_number)
    return nil
  end

  def isroute?(route_number)
    if @routes.include? route_number
      return true
    else
      return false
    end
  end

  def ismainstop?(stop_name)
    @mainstops.each{|m|
      if m.include? stop_name
        return true
      end
    }
    #return false
  end
  
  def all_routes
    return nil
  end

end

socrata_url = "http://opendata.socrata.com/resource/m9cr-ry5j.json"
