class CreateLakeDataFields < ActiveRecord::Migration
  def change
    create_table :lake_data_fields do |t|
      t.string :file
      t.string :field_name
      t.hstore :data

      t.timestamps null: false
    end
  end
end
