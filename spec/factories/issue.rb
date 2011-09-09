# encoding: utf-8

#require 'factory_girl/syntax/sham'

#Sham.issue_title {|n| "21000#{n}" }

Factory.define :issue, :default_strategy => :attributes_for do |issue|
  issue.file { File.open() }
end

