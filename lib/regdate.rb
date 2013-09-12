require 'date'
require 'csv'

class Regdate
  attr_accessor :date_array

  def initialize(contents)
    @date_array = []
    contents.each do |row|
      @date_array << clean_date(row[:regdate])
    end  
  end

  def most_popular_hour
    hours = @date_array.collect {|date| date.hour}
    return_most_occured(hours)        
  end

  def most_popular_wday
    days = @date_array.collect {|date| date.wday}
    return_most_occured(days)      
  end

  def clean_date(date)
    old_date = DateTime.strptime(date, "\%m\/\%e\/\%y\s\%H:\%M")
  end

  def frequencies(array)
    hash = {}
      array.each do |key|
        hash[key] ||= 0
        hash[key] += 1
      end
    return hash
  end

  def return_most_occured(array)
    hash = frequencies(array)
    clean_array = hash.values.to_a.sort!
    return hash.key(clean_array[-1])
  end
end