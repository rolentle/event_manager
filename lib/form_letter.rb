class FormLetter
  def initialize(contents, form_template)
    @contents = contents
    template_letter = File.read(form_template)
    @erb_template = ERB.new(template_letter)
    puts @erb_template
  end

  def create_letters
    @contents.each do |row|
      id = row[0]
      name = row[:first_name]
      zipcode = Zipcode.new(row[:zipcode])

      legislators = zipcode.legislators_by_zipcode
      form_letter = @erb_template.result(binding)

      save_thank_you_letters(id, form_letter)
    end
  end

  def save_thank_you_letters(id, form_letter)
    Dir.mkdir("output") unless Dir.exists? "output"
    output_letter = "output/thanks_#{id}.html"

    File.open(output_letter, "w") do |file|
      file.puts form_letter
      file.close
    end
  end
end