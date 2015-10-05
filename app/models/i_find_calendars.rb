require 'open-uri'
require 'icalendar'

class IFindCalendars

  def retrieve_calendar(url)
    web_contents  = open(url) {|f| f.read }

    cals = Icalendar.parse(web_contents)

    cals.first
  end
end
