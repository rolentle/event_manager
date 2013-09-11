class Regdate
  def popular_hour(dates)
    datehash = {}
    dates.each do |date|
      datehash[clean_date(date).hour] ||= 0
      datehash[clean_date(date).hour] += 1
    end

    dirtyarray = datehash.values.to_a
    dirtyarray.sort!
    return datehash.key(dirtyarray[-1])
  end

  def popular_day(dates)
    datehash = {}
    dates.each do |date|
      datehash[clean_date(date).wday] ||= 0
      datehash[clean_date(date).wday] += 1
    end
    dirtyarray = datehash.values.to_a
    dirtyarray.sort!
    return datehash.key(dirtyarray[-1])
  end

  private

  def clean_date(date)
    old_date = DateTime.strptime(date, "\%m\/\%e\/\%y\s\%H:\%M")
  end
end