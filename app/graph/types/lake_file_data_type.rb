LakeFileDataType = GraphQL::ObjectType.define do
  name "Lake File Data Field"
  description "Values for lake data"
  field :field, !types.String, 'File name of original EPA file'
  field :value, !types.String, 'value in field'
end