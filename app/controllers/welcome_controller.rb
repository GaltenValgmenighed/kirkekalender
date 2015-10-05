class WelcomeController < ApplicationController
  caches_action :index
  def index
    gava_url = 'https://www.google.com/calendar/ical/r9q5uk26psb23comadtso1isq0%40group.calendar.google.com/public/basic.ics'
    sgim_url = "https://www.google.com/calendar/ical/o1fv0807npa9acc1afas1cv50g%40group.calendar.google.com/public/basic.ics"

    @events = retrieve_calendar_events(gava_url, "GAVA")
    @events.concat(retrieve_calendar_events(sgim_url, "SGIM"))
    @events = @events
    .sort { |x,y| x.dtstart <=> y.dtstart}
    .select {|evt| evt.dtstart > Time.now}
  end

  private

  def find_calendars
    @find_calendars ||= IFindCalendars.new
  end

  def retrieve_calendar_events(url, name)
    cal = find_calendars.retrieve_calendar url
    events = cal.events.map do
      |evt| evt.custom_properties["source"] = name
      evt
    end
    events
  end
end
