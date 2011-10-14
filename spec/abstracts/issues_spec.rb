# encoding: utf-8

require 'spec_helper'

describe Issue do

 it { should have_many(:records) }

 let(:issue) { Factory :issue }

 it "после создания Issue должны создасться Record's" do
   issue.should be_persisted
   issue.reload.records.should_not be_empty
 end

end

