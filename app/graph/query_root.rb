QueryRoot = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :lake do
    type LakeType
    description "Find a Lake by site id"
    argument :site_id, !types.ID, "SITE_ID of lake"
    resolve -> (object, arguments, context) {
      Lake.find("NLA06608-0001")
    }
  end

  field :lakes do
    type -> {types[LakeType]}
    description "List of lakes"
    argument :search_string, !types.String, "Substring of text to search"
    resolve -> (object, arguments, context) {
      Lake.substring_search(arguments[:search_string]).limit(10)
    }

  end

end