class CreateLakeData < ActiveRecord::Migration
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :lake_data do |t|
      t.string :file
      t.string :site_id
      t.integer :visit_no
      t.hstore :data
    end
  end
end
