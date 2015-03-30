module RussianCases
  def genitive(word)
    cases = YAML.load_file("#{Rails.root}/lib/yaml/russian_cases.yml").with_indifferent_access
    genitive_case = cases[:cases][:genitive][word.mb_chars.downcase.to_s]
    return genitive_case if genitive_case.present?
    raise "There is not genitive implementation for \"#{word}\""
  end
end
