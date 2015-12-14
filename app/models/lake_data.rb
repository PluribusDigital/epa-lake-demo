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

  def method_missing(method_sym, *arguments, &block)
    data[method_sym.to_s.upcase]
  end

end