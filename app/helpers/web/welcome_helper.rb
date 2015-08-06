module Web::WelcomeHelper
  def text_news_tags
    [ [ 'Лидер', 'ActivityLine', 'ЛИДЕРСТВО'],
      [ 'Inформация', 'ActivityLine', 'ЖУРНАЛИСТИКА' ],
      [ 'Информационные технологии', 'ActivityLine', 'ИТ'],
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
      tags << [ departament.municipality, 'Team', departament.municipality ]
    end
    tags
  end
end
