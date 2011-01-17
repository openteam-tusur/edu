class AddVolumeToPlanCurriculum < ActiveRecord::Migration
  def self.up
    add_column :plan_curriculums, :volume, :integer
  end

  def self.down
    remove_column :plan_curriculums, :volume
  end
end
