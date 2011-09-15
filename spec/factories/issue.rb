# encoding: utf-8

Factory.define :issue do |issue|
  issue.data { File.open(Rails.root.join("spec", "abstracts_data", "ab01012007.iso")) }
  issue.association :disk
end

