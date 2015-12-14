LakeType = GraphQL::ObjectType.define do
  name "Lake"
  description "A lake surveyed by EPA"

  field :site_id, !types.ID, "The unique ID for the lake, or SITE_ID in EPA terms"
  field :lon_dd, !types.Float, "Longitude coordinate"
  field :lat_dd, !types.Float, "Latitude coordinate"
  field :lakename, !types.String, "Name of lake"
  field :epa_reg, !types.String, "EPA region jurisdiction"

end