class AddVolumeToWorkProgramm < ActiveRecord::Migration
  def self.up
    add_column :work_programms, :volume, :integer
  end

  def self.down
    remove_column :work_programms, :volume
  end
end
