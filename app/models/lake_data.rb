class LakeData < ActiveRecord::Base
  # Note: lake data comes from
  #  http://www2.epa.gov/national-aquatic-resource-surveys/data-national-aquatic-resource-surveys
  #  "Lakes 2007", "All" download file set

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

  def self.data_for_file(site_id,file,visit_no)
    result = LakeData.where(site_id:site_id,file:file,visit_no:visit_no)
    return result.first ? OpenStruct.new(result.first.data) : nil
  end

  def method_missing(method_sym, *arguments, &block)
    data[method_sym.to_s.downcase]
  end

  def visits
    [Visit.new(site_id,1),
     Visit.new(site_id,2)]
  end

end