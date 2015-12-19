QueryRoot = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :lake do
    type LakeType
    description "Find a Lake by site id"
    argument :site_id, !types.ID, "SITE_ID of lake"
    resolve -> (object, arguments, context) {
      Lake.find(arguments[:site_id])
    }
  end

  field :lakes do
    type -> {types[LakeType]}
    description "List of lakes"
    argument :search_string, !types.String, "Substring of text to search"
    resolve -> (object, arguments, context) {
      Lake.substring_search(arguments[:search_string])
    }
  end

  field :meta do
    type LakeFieldType
    description "Lake Field Metadata"
    argument :field_name, !types.String, "Field Name to match"
    resolve -> (object, arguments, context) {
      LakeDataField.match_name(arguments[:field_name])[0]
    }
  end

  field :lake_file_data do 
    type -> {types[LakeFileDataType]}
    description "data from a given file for a lake"
    argument :site_id, !types.ID, "Site ID of lake"
    argument :file, !types.String, "File Name to match"
    argument :visit_no, !types.String, "Visit Number to match"
    resolve -> (object, arguments, context) {
      LakeData.data_for_file(
        arguments[:site_id],
        arguments[:file],
        arguments[:visit_no])
    }
  end

end