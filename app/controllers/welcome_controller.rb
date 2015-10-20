class WelcomeController < ApplicationController
  caches_action :index, :expires_in => 5.minutes
  def index
    @events = []
    Calendar.all.each do |calendar| 
      @events.concat(retrieve_calendar_events(calendar.ics_url, calendar.name, calendar.info_url))
    end

    @events = @events
    .sort { |x,y| x.dtstart <=> y.dtstart}
    .select {|evt| evt.dtstart > Time.now}

  @news = News.news_in_the_future
  end

  private

  def find_calendars
    @find_calendars ||= IFindCalendars.new
  end

  def retrieve_calendar_events(url, name, info_url)
    cal = find_calendars.retrieve_calendar url
    events = cal.events.map do |evt|
      evt.custom_properties["source"] = name
      evt.custom_properties["info_url"] =  info_url
      evt
    end
    events
  end
end
