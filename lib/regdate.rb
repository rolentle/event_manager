require 'date'

class Regdate
  def initialize(date)
    @date = date
  end

  def most_popular_hour(date_array)
    datehash = {}
    date_array.each do |date|
      datehash[clean_date(date).hour] ||= 0
      datehash[clean_date(date).hour] += 1
    end

    clean_array = datehash.values.to_a
    clean_array.sort!
    return datehash.key(clean_array[-1])
  end

  def most_popular_day(date_array)
    datehash = {}
    date_array.each do |date|
      datehash[clean_date(date).wday] ||= 0
      datehash[clean_date(date).wday] += 1
    end

    clean_array = datehash.values.to_a
    clean_array.sort!
    return datehash.key(clean_array[-1])
  end

  private

  def clean_date(date)
    old_date = DateTime.strptime(date, "\%m\/\%e\/\%y\s\%H:\%M")
  end
end