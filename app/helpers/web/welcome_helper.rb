module Web::WelcomeHelper
  def text_news_tags
    [ [ 'Лидер', 'ActivityLine', 'ЛИДЕРСТВО'],
      [ 'Информация', 'ActivityLine', 'ЖУРНАЛИСТИКА' ],
      [ 'ИТ', 'ActivityLine', 'ИТ'],
      [ 'Право', 'ActivityLine', 'ПРАВО'],
      [ 'Диалог культур', 'ActivityLine', 'ТОЛЕРАНТНОСТЬ' ],
      [ 'Добро', 'ActivityLine',  'ВОЛОНТЁРСТВО' ],
      [ 'Корпоративные проекты', 'ActivityLine', 'КОРПОРАТИВНЫЕ ПРОЕКТЫ' ],
      [ 'НКО', 'string', 'НКО' ]
    ]
  end

  def municipalities_tags(departaments)
    tags = []
    departaments.each do |departament|
      tags << [ departament.municipality, 'Team', city_name(departament.municipality) ]
    end
    tags
  end

  private

  def city_name(municipality)
    municipality.sub('г. ', '').sub('район', 'р-н').to_s.mb_chars.upcase
  end
end
