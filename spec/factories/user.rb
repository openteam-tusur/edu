# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.email { |n| "test#{n}@mail.com" }

Factory.define :user, :default_strategy => :attributes_for do |user|
  user.email { Sham.email }
  user.password '123123'
  user.password_confirmation '123123'
end

