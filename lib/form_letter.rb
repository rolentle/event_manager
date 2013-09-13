class FormLetter
  attr_accessor :erb_template
  def initialize(contents)
    @contents = contents 
  end

  def create_letters_with(form_template)
    template_letter = File.read(form_template)
    @erb_template = ERB.new(template_letter)

    @contents.each do |row|
      id = row[0] 
      name = name[:first_name]
      zipcode = Zipcode.new(row[:zipcode])

      legislators = zipcode.legislators_by_zipcode
      form_letter = @erb_template.result(binding)

      save_letters(id, form_letter)
    end
  end

  def save_letters(id, form_letter)
    Dir.mkdir("output") unless Dir.exists? "output"
    output_letter = "output/thanks_#{id}.html"

    File.open(output_letter, "w") do |file|
      file.puts form_letter
      file.close
    end
  end
end 