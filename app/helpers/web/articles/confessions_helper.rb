module Web::Articles::ConfessionsHelper
  def nomination
    t('activerecord.attributes.activity_lines/corporative/confession.nomination').mb_chars.downcase.to_s
  end
end
