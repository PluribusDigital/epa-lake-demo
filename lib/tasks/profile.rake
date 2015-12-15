task :profile => [:environment] do 
  # Analyze columns in each table

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
      LakeDataField.create(file:file_name, field_name:field,data:data)
    end
    puts "~~~~~~~~~~~~~~~~~~~~~~~~"
  end
  
end