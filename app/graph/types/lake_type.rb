LakeType = GraphQL::ObjectType.define do
  name "Lake"
  field :visits,types[VisitType], "Visits for the survey"
  field :site_id, !types.ID, "The unique ID for the lake, or SITE_ID in EPA terms"
  field :lakename, !types.String, "Name of lake"
  field :epa_reg, !types.String, "EPA region jurisdiction"
  field :cntyname, !types.String, "County of lake"
  field :st, !types.String, "State (2-letter abbreviation)"
  field :lon_dd, !types.Float, "Longitude coordinate"
  field :lat_dd, !types.Float, "Latitude coordinate"
end