class Lake 

  FILES = ["PHab_Metrics_A", "PHab_CondtionEstimates", "Secchi", "Plankton_OEModel_ValidSitesUsed", "Recreational_ConditionEstimates", "PHab_IndexValues", "Plankton_OEModel_ConditionEstimates", "MeanDO_ConditionEstimate", "SampledLakeInformation", "Trophic_ConditionEstimate", "Profile", "WaterQuality", "Chemical_ConditionEstimates", "PHab_Metrics_B", "Buffer_Landuse_Metrics", "Basin_Landuse_Metrics", "MeanDO_Data", "Plankton_OEModel_AnalysisData"]

	def self.all
		LakeData.table('SampledLakeInformation').where(visit_no:1)
	end

  def self.find(site_id)
    all.where(site_id:site_id).limit(1).first
  end

  def self.substring_search(string)
  	substring_search_field('lakename',string) + substring_search_field('site_id',string)
  end

  def self.substring_search_field(field,string)
    all.where("lower(data -> ?) LIKE ?",field.upcase,"%#{string.downcase}%").limit(10)
  end

end