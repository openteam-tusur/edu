# encoding: utf-8

require 'spec_helper'

describe Issue do

 it { should have_many(:records) }

# it { should belongs_to(:year) }

 let(:issue) { Factory.create :issue }
 let(:first) { Abstracts::Parser.new(Rails.root.join("spec/abstracts_data/ab01012007.iso")) }

 describe "после создания Issue" do
   it "должны создасться Record's" do
     issue.records.first.month.should_not be_empty?
   end

   it "должны создасться Record's" do
     issue.title.should == "Январь 2007"
   end

 end

end

