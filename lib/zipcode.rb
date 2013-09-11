class Zipcode
  def initialize(zipcode)
    @zipcode = zipcode
  end
  
  def clean_zipcode
    @zipcode.to_s.rjust(5,"0")[0..4]
  end
end