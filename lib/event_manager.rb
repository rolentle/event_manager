require 'csv'
require 'erb'
require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'regdate'
require_relative 'form_letter'

puts "EventManager Initialized!"

@dates = []
regdates = Regdate.new
puts regdates.popular_hour(@dates)
puts regdates.popular_day(@dates)

formletter = Formletter.new('event_attendees.csv', 'form_letter.erb')
formletter.create_letter