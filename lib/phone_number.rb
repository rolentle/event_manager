class PhoneNumber
  attr_accessor :phone_number

  def initialize(phone_number)
    @phone_number = phone_number

    @phone_number.gsub!(/\D/, "")
  end

  def clean_number
    @phone_number = @phone_number[1..-1] if @phone_number.is_long_distance_format?
    @phone.is_number_valid? ?  @phone_number : @phone_number = "0000000000"
  end

  def long_distance_format?
   @phone_number.length == 11 && @phone_number[0] == "1" 
  end

  def is_number_valid?
    long_distance_format? || @phone_number.length  == 10
  end
end