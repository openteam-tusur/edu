# encoding: utf-8

require 'spec_helper'

describe Rj::Parser do

  before(:each) do
    @first = Rj::Parser.new(File.expand_path('../../rj_data/ab01012007.iso', __FILE__))
    @second = Rj::Parser.new(File.expand_path('../../rj_data/el022007.iso', __FILE__))
  end

  it 'должен возвращать тематику' do
    @first.topic_code.should eql 'ab01'
    @first.topic.should eql 'Автоматика и вычислительная техника'
    @second.topic_code.should eql 'el00'
    @second.topic.should eql 'Электротехника'
  end

  it 'должен возвращать номер' do
    @first.number.should eql '01'
    @second.number.should eql '02'
  end

  it 'должен возвращать год' do
    @first.year.should eql '2007'
    @second.year.should eql '2007'
  end

end

