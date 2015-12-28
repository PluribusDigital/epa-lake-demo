class Visit

  def initialize(site_id,visit_no)
    @visit_no = visit_no
    @site_id = site_id
  end

  def visit_no
    @visit_no
  end

  def method_missing(method_sym, *arguments, &block)
    # grab data for file if matches file name
    matched_file_name = Lake::FILES.select{|f| f.downcase == method_sym.to_s.downcase }.first
    LakeData.data_for_file(@site_id,matched_file_name,@visit_no) if matched_file_name
  end

end