require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

class Zipcode
  def initialize(zipcode)
    @zipcode = zipcode.to_s.rjust(5,"0")[0..4]
  end

  def legislators_by_zipcode
    legislators = Sunlight::Congress::Legislator.by_zipcode(@zipcode)
  end
end