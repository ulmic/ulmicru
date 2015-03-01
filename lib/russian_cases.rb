module RussianCases
  def genitive(word)
    cases = YAML.load_file("#{Rails.root}/lib/yaml/russian_cases.yml").with_indifferent_access
    cases[:cases][:genitive][word.mb_chars.downcase.to_s]
  end
end
