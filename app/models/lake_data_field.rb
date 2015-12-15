class LakeDataField < ActiveRecord::Base

  def self.graphql_fields_for_table(table)
    all.where(file:table).each do |f|
      puts "field :#{f.field_name.downcase.to_sym}, !types.#{translate_to_graphql_type(f.data['type'])}, 'Description Required by EPA'"
    end
  end

  def self.json_friendly_fields_for_table(table)
    all.where(file:table).map{|e|e.field_name.downcase}.join(",")
  end

  def self.translate_to_graphql_type(type)
    return "Float"   if type == "float"
    return "Integer" if type == "integer"
    return "String" 
  end

  def self.parse_data(datablob)
    # Hstore will do a 1-level key-value hash, but doesn't handle nested JSON well
    # Find those pairs and parse them
    # rescue the parse in case we are trying to parse a plain old string/value
    datablob.each do |key,val|
      datablob[key] = JSON.parse(val.gsub('=>',':')) rescue val 
    end
    datablob
  end
  
end
