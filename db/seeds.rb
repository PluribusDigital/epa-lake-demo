# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
	
# Find all CSV files, and import each into LakeData
Dir.entries("data").each do |filename|
	#only act on CSV
	if filename[-4..-1] == ".csv"
		table_name = filename[8..-5].sub(/[_]\d{8}/, "")
		puts "======"
		puts "Table: " + table_name
		CSV.foreach('data/'+filename,:headers => true, ) do |row|
      # downcase keys in row
      downcased_row = {}
      row.to_hash.each_pair do |k,v|
        downcased_row.merge!({k.downcase => v}) 
      end
			ld = LakeData.create(
					file: table_name,
					site_id: row["SITE_ID"],
					visit_no: row["VISIT_NO"].to_i,
					data: downcased_row
				)
			print "."
		end
	end
end


# Now generate the metadata for the LakeData fields
def field_names_for(table_dataset)
  table_dataset.first.data.map{|k,v|k}
end

def pluck_column(table_dataset, field_name)
  table_dataset.map{|r|r.data[field_name]}
end

Lake::FILES.each do |file_name|
  dataset = LakeData.table(file_name)
  field_names_for(dataset).each do |field|
    puts "#{file_name} > #{field}: "
    puts data = TypeMatch.analyze_set(pluck_column(dataset,field))  
    LakeDataField.create(file:file_name, field_name:field, data:data)
  end
  puts "~~~~~~~~~~~~~~~~~~~~~~~~"
end