#encoding: utf-8

require 'spec_helper'

describe WorkProgramm do
  before(:each) do
    @work_programm1 = Factory.create(:work_programm)
    @work_programm2 = Factory.create(:work_programm)
    @work_programm3 = Factory.create(:work_programm)
  end
  
  it "должен быть статус unpublished" do
    @work_programm1.state.should eql 'unpublished'
  end
  
  it 'кол-во рабочих опубликованных программ должно считаться правильно' do
    @work_programm1.update_attributes(:state => 'published')
    @work_programm2.update_attributes(:state => 'published')
    WorkProgramm.published.count.should   eql 2
    WorkProgramm.unpublished.count.should eql 1
    WorkProgramm.count.should             eql 3
  end
end

# == Schema Information
#
# Table name: work_programms
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  year          :integer         'Год издания'
#  state         :string(255)     'Статус'
#  access        :string(255)     'Доступ к файлу'
#  resource_name :text            'Название файла'
#  created_at    :datetime
#  updated_at    :datetime
#  title         :text            'Название'
#

