VisitType = GraphQL::ObjectType.define do
  name "Visit"
  description "Visit number for the survey (1 or 2)"
  field :visit_no, !types.Int, 'Visit number'
  field :sampledlakeinformation, SampledLakeInformationType, 'overall information about the sampled lake'
  field :basin_landuse_metrics, BasinLanduseMetricsType, 'data for basin_landuse_metrics'
  field :buffer_landuse_metrics, BufferLanduseMetricsType, 'data for buffer_landuse_metrics'
  field :chemical_conditionestimates, ChemicalConditionEstimatesType, 'data for chemical_conditionestimates'
  field :meando_conditionestimates, MeandoConditionEstimateType, 'data for meando_conditionestimates'
  field :phab_indexvalues, PhabIndexValuesType, 'data for phab_indexvalues'
  field :phab_metrics_a, PhabMetricsAType, 'data for phab_metrics_a'
  field :phab_metrics_b, PhabMetricsBType, 'data for phab_metrics_b'
  field :plankton_oemodel_analysisdata, PlanktonOemodelAnalysisDataType, 'data for plankton_oemodel_analysisdata'
  field :waterquality, WaterQualityType, 'data for waterquality'
end