class PhoneNumber
  def initialize(phone_number)
    @phone_number = phone_number
  end

  def clean_phone_number
    clean_number = @phone_number.gsub(/\D/, "")
    if clean_number.length == 11 && clean_number[0] == "1"
      clean_number = clean_number[1..-1]
    elsif clean_number.length != 10
      clean_number = "0000000000"
    else
      clean_number
    end
  end

end