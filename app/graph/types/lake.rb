LakeType = GraphQL::ObjectType.define do
  name "Lake"
  description "A lake surveyed by EPA"

  field :id, !types.ID, "The unique ID for the lake, or SITE_ID in EPA terms"
  # field :title, !types.String, "The title of this post"
  # field :body, !types.String,  "The body of this post"
end