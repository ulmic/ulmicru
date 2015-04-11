module RussianCases
  def case_word(word, case_name)
    cases = YAML.load_file("#{Rails.root}/lib/yaml/russian_cases.yml").with_indifferent_access
    word_case = cases[:cases][case_name][word.mb_chars.downcase.to_s]
    return word_case if word_case.present?
    raise "There is not #{case_name} implementation for \"#{word}\""
  end

  def genitive(word)
    case_word word, :genitive
  end

  def instrumental(word)
    case_word word, :instrumental
  end
end
