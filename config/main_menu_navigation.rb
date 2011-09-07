# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :training,
                 '<span class="decreased">для</span> учёбы',
                 training_path,
                 :highlights_on => /^\/training/

    primary.item :science,
                 '<span class="decreased">для</span> науки',
                 "#",
                 :highlights_on => /jopa/,
                 :class => 'need_tipsy',
                 :title => 'Раздел находится в разработке'

    primary.item :subfaculties,
                 '<span class="decreased">наши</span> кафедры',
                 chairs_path,
                 :highlights_on => /^\/chairs/

    primary.item :humans,
                 '<span class="decreased">наши</span> люди',
                 humans_path,
                 :highlights_on => /^\/humans/

    primary.item :library,
                 '<span class="decreased">наша</span> библиотека',
                 'http://lib.tusur.ru/'

    primary.item :help,
                 '<span class="decreased">наша</span> помощь',
                 help_path,
                 :highlights_on => /^\/help/
  end
end

