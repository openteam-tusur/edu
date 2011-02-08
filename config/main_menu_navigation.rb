# encoding: utf-8
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :training,
                 '<span class="decreased">для</span> учёбы',
                 "#",
                 :highlights_on => /jopa/

    primary.item :science,
                 '<span class="decreased">для</span> науки',
                 "#",
                 :highlights_on => /jopa/

    primary.item :subfaculties,
                 '<span class="decreased">наши</span> кафедры',
                 chairs_path,
                 :highlights_on => /^\/chairs/

    primary.item :humans,
                 '<span class="decreased">наши</span> люди',
                 humans_path,
                 :highlights_on => /jopa/

    primary.item :library,
                 '<span class="decreased">наша</span> библиотека',
                 'http://lib.tusur.ru/'
  end
end

