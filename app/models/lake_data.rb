class LakeData < ActiveRecord::Base

  def self.lakes
    # caonical list of individual lakes
    self.table('SampledLakeInformation').where(visit_no:1)
  end

  def self.lakes_by_data(key,value)
    where_by_key_value self.lakes, key, value
  end

	def self.table(table)
    # Table is source data file/table name
    self.where file:table
	end

  def self.where_table_key_value(table,key,value)
    where_by_key_value self.table(table), key, value
  end

  def self.where_by_key_value(set,key,value)
    set.where "data -> ? = ? ", key, value
  end

end