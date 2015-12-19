VisitType = GraphQL::ObjectType.define do
  name "Visit"
  description "Visit number for the survey (1 or 2)"
  field :visit_no, !types.Int, 'Visit number'
  field :phab_metrics_a, PhabMetricsAType, 'data for phab_metrics_a'
end