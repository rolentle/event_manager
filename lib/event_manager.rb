require 'csv'
require 'sunlight/congress'
require 'erb'
require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'regdate'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"


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

dates = []

contents.each do |row|
  id = row[0]

  name = row[:first_name]
  phone_number = PhoneNumber.new(row[:homephone])
  
  dates << row[:regdate]

  zipcode = Zipcode.new(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode.clean_zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id, form_letter)

end

regdates = Regdate.new

puts regdates.popular_hour(dates)
puts regdates.popular_day(dates)