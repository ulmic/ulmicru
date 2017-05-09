module RussianCases
  def case_word(word, case_name)
    @cases ||= load_yml[:cases]
    word_case = @cases[case_name][word.mb_chars.downcase.to_s]
    return word_case if word_case.present?
    raise "There is not #{case_name} implementation for \"#{word}\""
  end

  def genitive(word)
    case_word word, :genitive
  end

  def instrumental(word)
    case_word word, :instrumental
  end

  def dative(word)
    case_word word, :dative
  end

  private

  def load_yml
    @_cache_russian_cases_yml ||= YAML.load_file("#{Rails.root}/lib/yaml/russian_cases.yml").with_indifferent_access
  end
end
