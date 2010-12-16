# encoding: utf-8

require 'spec_helper'

describe 'Специальность' do
  it 'при создании специальности должны создаваться семестры' do
    speciality = Factory.create(:speciality)
  end
end

