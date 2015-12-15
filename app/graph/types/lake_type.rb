LakeType = GraphQL::ObjectType.define do
  name "Lake"
  description "A lake surveyed by EPA"
  field :site_id, !types.ID, "The unique ID for the lake, or SITE_ID in EPA terms"
  field :lakename, !types.String, "Name of lake"
  field :epa_reg, !types.String, "EPA region jurisdiction"
  field :cntyname, !types.String, "County of lake"
  field :st, !types.String, "State (2-letter abbreviation)"
  field :lon_dd, !types.Float, "Longitude coordinate"
  field :lat_dd, !types.Float, "Latitude coordinate"
  field :sld, !types.Float, 'Description Required by EPA'
  field :tnt, !types.String, 'Description Required by EPA'
  field :wgt, !types.Float, 'Description Required by EPA'
  field :fid_1, !types.Int, 'Description Required by EPA'
  field :huc_2, !types.Float, 'Description Required by EPA'
  field :huc_8, !types.Float, 'Description Required by EPA'
  field :panel, !types.String, 'Description Required by EPA'
  field :urban, !types.String, 'Description Required by EPA'
  field :com_id, !types.Int, 'Description Required by EPA'
  field :mdcaty, !types.Float, 'Description Required by EPA'
  field :repeat, !types.String, 'Description Required by EPA'
  field :rt_nla, !types.String, 'Description Required by EPA'
  field :sewage, !types.String, 'Description Required by EPA'
  field :area_ha, !types.Float, 'Description Required by EPA'
  field :depth_x, !types.Float, 'Description Required by EPA'
  field :elev_pt, !types.Float, 'Description Required by EPA'
  field :fld_src, !types.String, 'Description Required by EPA'
  field :neslake, !types.String, 'Description Required by EPA'
  field :nhdname, !types.String, 'Description Required by EPA'
  field :nut_reg, !types.String, 'Description Required by EPA'
  field :sampled, !types.String, 'Description Required by EPA'
  field :stratum, !types.String, 'Description Required by EPA'
  field :wgt_nla, !types.Float, 'Description Required by EPA'
  field :albers_x, !types.Float, 'Description Required by EPA'
  field :albers_y, !types.Float, 'Description Required by EPA'
  field :date_col, !types.String, 'Description Required by EPA'
  field :depthmax, !types.Float, 'Description Required by EPA'
  field :disposal, !types.String, 'Description Required by EPA'
  field :dsgn_cat, !types.String, 'Description Required by EPA'
  field :eco_nuta, !types.String, 'Description Required by EPA'
  field :fld_flag, !types.String, 'Description Required by EPA'
  field :lakearea, !types.Float, 'Description Required by EPA'
  field :ref_nutr, !types.String, 'Description Required by EPA'
  field :visit_id, !types.Int, 'Description Required by EPA'
  field :visit_no, !types.String, 'Description Required by EPA'
  field :wsa_eco3, !types.String, 'Description Required by EPA'
  field :wsa_eco9, !types.String, 'Description Required by EPA'
  field :area_cat7, !types.String, 'Description Required by EPA'
  field :eco_lev_3, !types.Int, 'Description Required by EPA'
  field :evaporate, !types.String, 'Description Required by EPA'
  field :flag_info, !types.String, 'Description Required by EPA'
  field :lakeperim, !types.Float, 'Description Required by EPA'
  field :lake_samp, !types.String, 'Description Required by EPA'
  field :reachcode, !types.Float, 'Description Required by EPA'
  field :site_type, !types.String, 'Description Required by EPA'
  field :srfc_area, !types.String, 'Description Required by EPA'
  field :adjwgt_cat, !types.String, 'Description Required by EPA'
  field :aquacultur, !types.String, 'Description Required by EPA'
  field :eco_l3_nam, !types.String, 'Description Required by EPA'
  field :fld_lat_dd, !types.Float, 'Description Required by EPA'
  field :fld_lon_dd, !types.Float, 'Description Required by EPA'
  field :index_samp, !types.String, 'Description Required by EPA'
  field :meter_deep, !types.String, 'Description Required by EPA'
  field :neslake_id, !types.String, 'Description Required by EPA'
  field :non_saline, !types.String, 'Description Required by EPA'
  field :open_water, !types.String, 'Description Required by EPA'
  field :perm_water, !types.String, 'Description Required by EPA'
  field :phys_acces, !types.String, 'Description Required by EPA'
  field :size_class, !types.String, 'Description Required by EPA'
  field :state_name, !types.String, 'Description Required by EPA'
  field :status_dsk, !types.String, 'Description Required by EPA'
  field :status_fld, !types.String, 'Description Required by EPA'
  field :status_ver, !types.String, 'Description Required by EPA'
  field :lake_origin, !types.String, 'Description Required by EPA'
  field :nutreg_name, !types.String, 'Description Required by EPA'
  field :ref_cluster, !types.String, 'Description Required by EPA'
  field :sampled_inf, !types.String, 'Description Required by EPA'
  field :comment_info, !types.String, 'Description Required by EPA'
  field :indxsamp_inf, !types.String, 'Description Required by EPA'
  field :refclus_name, !types.String, 'Description Required by EPA'
  field :sampled_chem, !types.String, 'Description Required by EPA'
  field :sampled_chla, !types.String, 'Description Required by EPA'
  field :sampled_core, !types.String, 'Description Required by EPA'
  field :sampled_ente, !types.String, 'Description Required by EPA'
  field :sampled_micr, !types.String, 'Description Required by EPA'
  field :sampled_phab, !types.String, 'Description Required by EPA'
  field :sampled_phyt, !types.String, 'Description Required by EPA'
  field :sampled_sdhg, !types.String, 'Description Required by EPA'
  field :sampled_zoop, !types.String, 'Description Required by EPA'
  field :eco3_x_origin, !types.String, 'Description Required by EPA'
  field :indxsamp_chem, !types.String, 'Description Required by EPA'
  field :indxsamp_chla, !types.String, 'Description Required by EPA'
  field :indxsamp_core, !types.String, 'Description Required by EPA'
  field :indxsamp_ente, !types.String, 'Description Required by EPA'
  field :indxsamp_micr, !types.String, 'Description Required by EPA'
  field :indxsamp_phab, !types.String, 'Description Required by EPA'
  field :indxsamp_phyt, !types.String, 'Description Required by EPA'
  field :indxsamp_sdhg, !types.String, 'Description Required by EPA'
  field :indxsamp_zoop, !types.String, 'Description Required by EPA'
  field :sampled_assess, !types.String, 'Description Required by EPA'
  field :sampled_secchi, !types.String, 'Description Required by EPA'
  field :sampled_profile, !types.String, 'Description Required by EPA'
end