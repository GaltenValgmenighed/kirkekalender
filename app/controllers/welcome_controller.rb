class WelcomeController < ApplicationController
  def index

    gava_url = 'https://www.google.com/calendar/ical/r9q5uk26psb23comadtso1isq0%40group.calendar.google.com/public/basic.ics'
    sgim_url = "https://www.google.com/calendar/ical/o1fv0807npa9acc1afas1cv50g%40group.calendar.google.com/public/basic.ics"
    find_calendars = IFindCalendars.new
    gava_cal = find_calendars.retrieve_calendar gava_url
    sgim_cal = find_calendars.retrieve_calendar sgim_url

    gava_events = gava_cal.events.map { |evt| evt.custom_properties["source"]="GAVA";evt}
    sgim_events = sgim_cal.events.map { |evt| evt.custom_properties["source"]="SGIM";evt}
    @events = gava_events
    @events.concat(sgim_events)
    @events = @events
    .sort { |x,y| x.dtstart <=> y.dtstart}
      .select {|evt| evt.dtstart > Time.now}
  end
end
