class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.references :chair
      t.string :title
      t.integer :year
      t.integer :volume
      t.string :state
      t.string :access
      t.string :kind
      t.string :isbn
      t.string :udk
      t.string :bbk
      t.string :stamp

      t.timestamps
    end

    drop_table :work_programms
    drop_table :work_books

    rename_column :plan_educations, :work_programm_id, :publication_id
  end

  def self.down
    drop_table :publications

    create_table :work_programms do |t|
      t.string :title
      t.references :chair
      t.integer :year
      t.string :state
      t.string :access
      t.text :resource_name

      t.timestamps
    end

    create_table :work_books do |t|
      t.string :title
      t.integer :year
      t.integer :volume
      t.string :state
      t.string :access
      t.integer :chair_id

      t.timestamps
    end

    rename_column :plan_educations, :publication_id, :work_programm_id
  end
end

