
# == Schema Information
#
# Table name: plan_educations
# Human name: Дисциплина
#
#  id                     :integer         not null, primary key
#  semester_id            :integer
#  discipline_id          :integer
#  loading_lecture        :integer         'Лекции'
#  loading_laboratory     :integer         'Лабораторные занятия'
#  loading_practice       :integer         'Практические занятия'
#  loading_course_project :integer         'Курсовое проектирование'
#  loading_course_work    :integer         'Курсовая работа'
#  loading_self_training  :integer         'Самостоятельная работа'
#  created_at             :datetime
#  updated_at             :datetime
#  chair_id               :integer
#

