# encoding: utf-8

Factory.define :human, :default_strategy => :attributes_for do |human|
  human.association :user
end

