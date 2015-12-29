LakeFieldType = GraphQL::ObjectType.define do
  name "LakeField"
  description "Metadata on lake field"
  field :file, !types.String, 'File name of original EPA file'
  field :field_name, !types.String, 'Name of field (i.e. CSV column header)'
  field :type, !types.String, 'Automatically derived data type'
  field :values, !types.String, 'Statistics on values in field'
end