require 'csv'
require 'sunlight/congress'
require 'erb'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  clean_number = phone_number.gsub(/\D/, "")
  if clean_number.length == 11 && clean_number[0] == "1"
    clean_number = clean_number[1..-1]
  elsif clean_number.length != 10
    clean_number = "0000000000"
  else
    clean_number
  end
end

def clean_date(date)
  old_date = DateTime.strptime(date, "\%m\/\%e\/\%y\s\%H:\%M")
end

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


def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, "w") do |file|
    file.puts form_letter
  end
end


puts "EventManager Initialized!"

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)
end
