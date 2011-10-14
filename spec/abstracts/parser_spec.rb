# encoding: utf-8

require 'spec_helper'

describe Abstracts::Parser do

  let(:first) { Abstracts::Parser.new(Rails.root.join("spec/abstracts_data/ab01012007.iso")) }
  let(:second) { Abstracts::Parser.new(Rails.root.join("spec/abstracts_data/el022007.iso")) }



  describe "данные записей" do

    def records; first.records end

    it 'должен считывать все записи' do
      records.size.should == 3
    end

    it "должны заменяться спец-символы знаком ~%" do
      records.first.fields["100"].should include('≠')
    end

  end

end

