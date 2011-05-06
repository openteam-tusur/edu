#encoding: utf-8

require 'spec_helper'

describe Publication do
  before(:each) do
    @publication = Factory.create(:publication)
  end

  it "должен быть статус unpublished" do
    @publication.state.should eql 'unpublished'
  end

  it 'кол-во рабочих опубликованных программ должно считаться правильно' do
    @publication2 = Factory.create(:publication)
    @publication3 = Factory.create(:publication)
    @publication.update_attributes(:state => 'published')
    @publication2.update_attributes(:state => 'published')
    Publication.published.count.should   eql 2
    Publication.unpublished.count.should eql 1
    Publication.count.should             eql 3
  end

  it 'должны привязываться авторы' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @publication.update_attributes :authors_attributes => [
      { :human =>  @bankin }
    ]

    @publication.authors.first.human.should eql @bankin
  end

  it 'должен создаваться объект из хэша' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @chair = Factory.create :chair
    @wp = @chair.publications.create! Factory(:publication).merge(:authors_attributes => [{:human_id => @bankin.id}])
    @wp.authors.collect(&:human).should eql [@bankin]
  end

  it "должна получать сгруппированные по специальностям дисциплины" do
    curriculum = Factory.create(:curriculum)
    study = Factory.create(:study, :curriculum => curriculum, :discipline_name => "дисциплина 1")
    education = Factory.create(:education, :semester => curriculum.semesters.first, :study => study)
    education_2 = Factory.create(:education, :semester => curriculum.semesters.last, :study => study)
    study_2 = Factory.create(:study, :curriculum => curriculum, :discipline_name => "дисциплина 2")
    education_3 = Factory.create(:education, :semester => curriculum.semesters.first, :study => study_2)
    Factory.create(:education, :semester => curriculum.semesters.first)

    curriculum_2 = Factory.create(:curriculum)
    education_4 = Factory.create(:education, :semester => curriculum_2.semesters.first,
                                :study => Factory.create(:study, :curriculum => curriculum_2))

    publication_discipline = @publication.publication_disciplines.create!(:discipline => education.discipline, :education_ids => [education.id, education_2.id])
    publication_discipline_2 = @publication.publication_disciplines.create!(:discipline => education_3.discipline, :education_ids => [education_3.id])

    publication_discipline_3 = @publication.publication_disciplines.create!(:discipline => education_4.discipline, :education_ids => [education_4.id])

    expected_result = {
      curriculum.speciality => [publication_discipline, publication_discipline_2],
      curriculum_2.speciality => [publication_discipline_3]
    }

    @publication.grouped_disciplines.should eql expected_result

  end

end


# == Schema Information
#
# Table name: publications
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  title         :string(255)
#  year          :integer
#  volume        :integer
#  state         :string(255)
#  access        :string(255)
#  kind          :string(255)
#  isbn          :string(255)
#  udk           :string(255)
#  bbk           :string(255)
#  stamp         :text
#  created_at    :datetime
#  updated_at    :datetime
#  content       :text
#  annotation    :text
#  extended_kind :string(255)
#  comment       :text
#

