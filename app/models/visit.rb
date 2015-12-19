class Visit

  def initialize(site_id,visit_no)
    @visit_no = visit_no
    @site_id = site_id
  end

  def visit_no
    @visit_no
  end

  def phab_metrics_a
    LakeData.data_for_file(@site_id,'PHab_Metrics_A',@visit_no)
  end

end