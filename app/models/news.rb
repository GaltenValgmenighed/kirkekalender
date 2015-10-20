class News < ActiveRecord::Base

  def self.news_in_the_future
    News.where("startdate < ? AND enddate > ?", Time.now, Time.now).order('startdate ASC')
  end
end
