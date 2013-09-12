require 'csv'
require 'erb'
require_relative 'phone_number'
require_relative 'zipcode'
require_relative 'regdate'
require_relative 'form_letter'

class EventManager
  attr_accessor :contents

  def initialize(input_file)
    @contents = CSV.open input_file, headers: true, header_converters: :symbol
  end
end 
