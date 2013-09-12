class FormLetter

  def save_thank_you_letters(id, form_letter)
    Dir.mkdir("output") unless Dir.exists? "output"
    output_letter = "output/thanks_#{id}.html"

    File.open(output_letter, "w") do |file|
      file.puts @template_letter
      file.close
    end
  end

end