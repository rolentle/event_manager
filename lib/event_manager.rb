require 'csv'
require 'erb'
require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'regdate'
require_relative 'form_letter'

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
dates = []
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  date = Regdate.new(row[:regdate])
  dates << row[:regdate]
  name = row[:first_name]
  phone_number = PhoneNumber.new(row[:homephone])
  zipcode = Zipcode.new(row[:zipcode])
  legislators = zipcode.legislators_by_zipcode
  form_letter = erb_template.result(binding)

  letter_maker = FormLetter.new
  letter_maker.save_thank_you_letters(id,form_letter)
end

puts "EventManager Initialized!"

regdates = Regdate.new(dates)
puts "Most popular hour to register:"
puts regdates.most_popular_hour(dates)
puts "Most popular day to register:"
puts regdates.most_popular_day(dates)