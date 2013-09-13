require 'csv'
require 'erb'
require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'regdate'
require_relative 'form_letter'

class EventManager
  attr_accessor :contents, :regdates, :form_letter

  def initialize(input_file)
    @contents = CSV.open input_file, headers: true, header_converters: :symbol
    @regdates = Regdate.new(@contents)
    @form_letter = FormLetter.new(@contents)
  end

  def regdates=(contents)
    @regdates = Regdate.new(@contents)
  end
end 
