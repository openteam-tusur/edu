# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :training,
                 '<span class="decreased">для</span> учёбы',
                 publications_path,
                 :highlights_on => /^\/training/

    primary.item :science,
                 '<span class="decreased">для</span> науки',
                 records_path,
                 :highlights_on => /^\/records/

    primary.item :subfaculties,
                 '<span class="decreased">наши</span> кафедры',
                 chairs_path,
                 :highlights_on => /^\/chairs/

    primary.item :humans,
                 '<span class="decreased">наши</span> специальности',
                 'http://plans.tusur.ru/plans'
    primary.item :library,
                 '<span class="decreased">наша</span> библиотека',
                 'http://lib.tusur.ru/',
                 :class => 'target_blank'

    primary.item :help,
                 '<span class="decreased">наша</span> помощь',
                 help_path,
                 :highlights_on => /^\/help/
  end
end

