# Plankton_OEModel_AnalysisData
PlanktonOemodelAnalysisDataType = GraphQL::ObjectType.define do
  name "PlanktonOEModelAnalysisData"
  description "Data Description Required by EPA"
  field :otu_oe5, !types.String, 'Description Required by EPA'
  field :site_id, !types.String, 'Description Required by EPA'
  field :visit_no, !types.String, 'Description Required by EPA'
  field :abund_oe5, !types.Float, 'Description Required by EPA'
  field :sample_category, !types.String, 'Description Required by EPA'
end