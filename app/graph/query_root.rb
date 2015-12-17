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
      LakeDataField.where(field_name:arguments[:field_name]).first
    }
  end

end