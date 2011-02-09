class RemoveTimeStampsFromEducationsExaminations < ActiveRecord::Migration
  def self.up
    remove_columns :educations_examinations, :created_at
    remove_columns :educations_examinations, :updated_at
  end

  def self.down
    add_columns :educations_examinations, :updated_at, :datetime
    add_columns :educations_examinations, :created_at, :datetime
  end
end
