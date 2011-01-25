# encoding: utf-8

Sham.name { |n| "Объект #{n}" }

Factory.define :human, :default_strategy => :attributes_for do |human|
  human.name { Sham.name }
  human.patronymic "Факториевич"
  human.surname "Генераторов"
end

