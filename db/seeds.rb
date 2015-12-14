# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
	# Find the files
	Dir.entries("data").each do |filename|
		#only act on CSV

		if filename[-4..-1] == ".csv"
			table_name = filename[8..-5].sub(/[_]\d{8}/, "")
			puts "======"
			puts "Table: " + table_name
			
			CSV.foreach('data/'+filename,:headers => true, ) do |row|
				ld = LakeData.create(
						file: table_name,
						site_id: row["SITE_ID"],
						visit_no: row["VISIT_NO"].to_i,
						data: row.to_h
					)
				print "."
			end
		end
	end