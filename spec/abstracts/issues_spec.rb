# encoding: utf-8

require 'spec_helper'

describe Issue do

 it { should have_many(:records) }

 let(:issue) { Factory :issue }
#    issue.save!
#    issue.data = File.new(Rails.root.join("spec/abstracts_data2/ab01012008.iso"))
#    issue.save!
#    issue
# end

 describe "после создания Issue" do

   it "должны создасться Record's" do
     issue.records.should_not be_empty
   end

   pending "Должен быть четкий титл" do
     issue.title.should == "Январь 2007"
   end

 end

end

