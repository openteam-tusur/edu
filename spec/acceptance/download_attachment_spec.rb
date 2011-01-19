# encoding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Скачивание файлов" do

  before(:each) do
    @curriculum = Factory.create(:plan_curriculum,
                          :semesters_count => 10,
                          :access => "free",
                          :year => "2010",
                          :volume => 200,
                          :attachment_attributes => {:data => File.new(Rails.root.join("spec", "data", "plan-210400.pdf"))})
#    @curriculum.create_attachment(:data => ))
  end

  scenario "должен скачиваться файл, версия которого полностью открытая" do
    visit @curriculum.attachment.data.url
    page.driver.response_headers["Content-Transfer-Encoding"].should eql "binary"
  end

  scenario "должен приходить 403, если файл файлы версии недоступны" do
    @curriculum.update_attribute(:access, "restricted")
    visit @curriculum.attachment.data.url
    page.status_code.should be 403
  end

end

