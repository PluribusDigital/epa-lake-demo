# NOTE
# Deleted Phytoplankton, SedimentDiatoms, VisualAssessment, Zooplankton 
# 	files becauase of invalid encoding on source file

task :slurp => [:environment] do 

	require 'csv'
	# Clear Out Data
	LakeData.all.each{|ld|ld.delete}
	# Find the files
	Dir.entries("data").each do |filename|
		#only act on CSV

		if filename[-4..-1] == ".csv"
			table_name = filename[8..-5].sub(/[_]\d{8}/, "")
			puts "======"
			puts "Table: " + table_name
			
			CSV.foreach('data/'+filename,:headers => true, ) do |row|
				ld = LakeData.new(
						file: table_name,
						site_id: row["SITE_ID"],
						visit_no: row["VISIT_NO"].to_i,
						data: row.to_h
					)
				ld.save! and print "."
			end
		end
	end

end