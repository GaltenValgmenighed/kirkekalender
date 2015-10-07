class WelcomeController < ApplicationController
  caches_action :index
  def index
    @events = []
    Calendar.all.each do |calendar| 
    @events.concat(retrieve_calendar_events(calendar.ics_url, calendar.name))
    end

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
