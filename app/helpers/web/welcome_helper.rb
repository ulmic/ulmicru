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
      #FIXME запросы из хелпера!
      if departament.tags.any?
        tags << [ departament.municipality, 'Team', departament.municipality ]
      end
    end
    tags
  end
end
