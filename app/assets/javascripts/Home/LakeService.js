app.factory('LakeService',
    function ($http) {
        'use strict';

        var service = {
           error: function (response) {
                console.log('error when calling Lakes API');
                console.log(response);
                return [];
            },

            searchSuccess: function (response) {
                return response.data.data.lakes;
            },

            // These methods encapsulate API calls
            search: function (substring) {
                return $http.post('/queries', {
                    query: "query search($searchString:String!) {lakes(search_string: $searchString){site_id,lakename,cntyname,st}}",
                    variables: {'searchString':substring}
                })
                .then(this.searchSuccess, this.error);
            },

            get: function (site_id, successFunction) {
                return $http.post('/queries', {
                    query: "query getLake($site_id:ID!) { \
                              lake(site_id: $site_id){ \
                                st,sld,tnt,wgt,fid_1,huc_2,huc_8,panel,urban,com_id,lat_dd,lon_dd,mdcaty,repeat,rt_nla,sewage,area_ha,depth_x,elev_pt,epa_reg,fld_src,neslake,nhdname,nut_reg,sampled,site_id,stratum,wgt_nla,albers_x,albers_y,cntyname,date_col,depthmax,disposal,dsgn_cat,eco_nuta,fld_flag,lakearea,lakename,ref_nutr,visit_id,visit_no,wsa_eco3,wsa_eco9,area_cat7,eco_lev_3,evaporate,flag_info,lakeperim,lake_samp,reachcode,site_type,srfc_area,adjwgt_cat,aquacultur,eco_l3_nam,fld_lat_dd,fld_lon_dd,index_samp,meter_deep,neslake_id,non_saline,open_water,perm_water,phys_acces,size_class,state_name,status_dsk,status_fld,status_ver,lake_origin,nutreg_name,ref_cluster,sampled_inf,comment_info,indxsamp_inf,refclus_name,sampled_chem,sampled_chla,sampled_core,sampled_ente,sampled_micr,sampled_phab,sampled_phyt,sampled_sdhg,sampled_zoop,eco3_x_origin,indxsamp_chem,indxsamp_chla,indxsamp_core,indxsamp_ente,indxsamp_micr,indxsamp_phab,indxsamp_phyt,indxsamp_sdhg,indxsamp_zoop,sampled_assess,sampled_secchi,sampled_profile, \
                                visits{visit_no \
                                    , basin_landuse_metrics{visit_no,lake_samp,site_type,basinarea_ha,basinarea_km2,flag_lu_basin,pct_agric_bsn,pct_conif_bsn,pct_crops_bsn,pct_decid_bsn,pct_grass_bsn,pct_mixed_bsn,pct_water_bsn,nlcd11_km2_bsn,nlcd12_km2_bsn,nlcd21_km2_bsn,nlcd22_km2_bsn,nlcd23_km2_bsn,nlcd24_km2_bsn,nlcd31_km2_bsn,nlcd32_km2_bsn,nlcd41_km2_bsn,nlcd42_km2_bsn,nlcd43_km2_bsn,nlcd51_km2_bsn,nlcd52_km2_bsn,nlcd71_km2_bsn,nlcd72_km2_bsn,nlcd73_km2_bsn,nlcd74_km2_bsn,nlcd81_km2_bsn,nlcd82_km2_bsn,nlcd90_km2_bsn,nlcd91_km2_bsn,nlcd92_km2_bsn,nlcd93_km2_bsn,nlcd94_km2_bsn,nlcd95_km2_bsn,nlcd96_km2_bsn,nlcd97_km2_bsn,nlcd98_km2_bsn,nlcd99_km2_bsn,pct_barren_bsn,pct_devlow_bsn,pct_devmed_bsn,pct_forest_bsn,pct_wdywet_bsn,landuse_km2_bsn,pct_devhigh_bsn,pct_devopen_bsn,pct_icesnow_bsn,pct_openh20_bsn,pct_pasture_bsn,pct_wetland_bsn,basinarea_lu_km2,comment_lu_basin,missdata_km2_bsn,pct_developed_bsn,pct_emherbwet_bsn,pct_shrubland_bsn} \
                                    , buffer_landuse_metrics{visit_no,lake_samp,site_type,bufferarea_ha,distance_bufr,bufferarea_km2,flag_lu_buffer,pct_agric_bufr,pct_conif_bufr,pct_crops_bufr,pct_decid_bufr,pct_grass_bufr,pct_mixed_bufr,pct_water_bufr,nlcd11_km2_bufr,nlcd12_km2_bufr,nlcd21_km2_bufr,nlcd22_km2_bufr,nlcd23_km2_bufr,nlcd24_km2_bufr,nlcd31_km2_bufr,nlcd32_km2_bufr,nlcd41_km2_bufr,nlcd42_km2_bufr,nlcd43_km2_bufr,nlcd51_km2_bufr,nlcd52_km2_bufr,nlcd71_km2_bufr,nlcd72_km2_bufr,nlcd73_km2_bufr,nlcd74_km2_bufr,nlcd81_km2_bufr,nlcd82_km2_bufr,nlcd90_km2_bufr,nlcd91_km2_bufr,nlcd92_km2_bufr,nlcd93_km2_bufr,nlcd94_km2_bufr,nlcd95_km2_bufr,nlcd96_km2_bufr,nlcd97_km2_bufr,nlcd98_km2_bufr,nlcd99_km2_bufr,pct_barren_bufr,pct_devlow_bufr,pct_devmed_bufr,pct_forest_bufr,pct_wdywet_bufr,landuse_km2_bufr,pct_devhigh_bufr,pct_devopen_bufr,pct_icesnow_bufr,pct_openh20_bufr,pct_pasture_bufr,pct_wetland_bufr,comment_lu_buffer,missdata_km2_bufr,pct_developed_bufr,pct_emherbwet_bufr,pct_shrubland_bufr} \
                                    , chemical_conditionestimates{rt_nla,epa_reg,neslake,nut_reg,st,anc,doc,ntl,ptl,tnt,wgt,chla,cond,turb,huc_2,huc_8,panel,urban,lat_dd,lon_dd,mdcaty,sampled,site_id,stratum,wgt_nla,anc_cond,dsgn_cat,eco_nuta,ntl_cond,ptl_cond,visit_no,wsa_eco3,wsa_eco9,area_cat7,chla_cond,eco_lev_3,flag_info,lake_samp,site_type,turb_cond,adjwgt_cat,lake_origin,nutreg_name,ref_cluster,comment_info,sampled_chem,sampled_chla,eco3_x_origin,indxsamp_chem,indxsamp_chla,salinity_cond} \
                                    , phab_indexvalues{site_type,st,uid,wmt,xer,year,ecop6,rvegq,classp,area_ha,litcvrq,rdis_ix,rveg_oe,rvegq_7,rvegq_8,site_id,datephab,elevdlat,elevxlat,elevxlon,logrvegq,lrcvq_7a,lrcvq_7b,lrcvq_7c,lrcvq_7d,lrcvq_8d,visit_no,wsa_eco3,wsa_eco9,l_rvegq_8,lake_samp,litcvr_oe,litripcvq,rdis_inex,rvegq_var,ssibedbld,l_lrcvq_8d,loglitcvrq,rvilowwood,xer_x_elev,litcvrq_var,litripcvr_oe,loe_rvq_west,loglitripcvq,rdisixagadj2,rdisixagadj3,rdisixagadj4,rdisixagadj5,sampled_phab,ssinatbedbld,litripcvq_var,loe_litcv_west,adj3a_l_litcvrq,adj3a_l_rvegq_8,pre3a_l_litcvrq,pre3a_l_rvegq_8,adj3a_l_lrcvq_8d,pre3a_l_lrcvq_8d,loe_litripcv_west} \
                                    , phab_metrics_a{st,uid,year,amnall,amvall,bsfh2s,bsfoil,bsfred,fciall,fcibig,fcnall,site_id,amfcall,amfpall,amidall,amiqall,bsfgray,bsnodor,bsnsand,bsnsilt,bsnwood,bsoodor,bsvldia,bsvsand,bsvsilt,bsvwood,bsxldia,fcfpall,fcnsnag,fcvsnag,lzofilm,datephab,visit_no,amitotal,bs16ldia,bs25ldia,bs50ldia,bs75ldia,bs84ldia,bsfblack,bsfbrown,bsfcsand,bsfcsilt,bsfcwood,bsfpsand,bsfpsilt,bsfpwood,bsncolor,bsocolor,fcfcsnag,fcfpsnag,fcnbrush,fcvbrush,lzfpfilm} \
                                    , phab_metrics_b{st,uid,year,hiiag,hinag,hiiall,hinall,hipwag,rdisin,bffflat,hifpany,hinlawn,hinpark,hipwall,lmfpmud,lmfpveg,rvegq_1,rvegq_2,rvegq_3,rvegq_4,rvegq_5,rvegq_6,site_id,ssnsand,ssnsilt,ssnwood,ssvldia,ssvsand,ssvsilt,ssvwood,ssxldia,bffsteep,bfnangle,bfoangle,datephab,hiinonag,hincrops,hindocks,hinnonag,hinroads,hinwalls,hipwlawn,hipwpark,litcvr_a,litcvr_b,litcvr_c,litcvr_d,lmfpfill,lmfpnone,lmfpsand,lmncover,lmnhuman,lmocover,lrcvq_1a,lrcvq_1b,lrcvq_1c,lrcvq_1d,lrcvq_2a,lrcvq_2b,lrcvq_2c,lrcvq_2d,lrcvq_3a,lrcvq_3b,lrcvq_3c,lrcvq_3d,lrcvq_4a,lrcvq_4b,lrcvq_4c,lrcvq_4d,lrcvq_5a,lrcvq_5b,lrcvq_5c,lrcvq_5d,lrcvq_6a,lrcvq_6b,lrcvq_6c,lrcvq_6d,rdisinag,rvegq_5a,rvegq_6a,ss16ldia,ss25ldia,ss50ldia,ss75ldia,ss84ldia,ssfcsand,ssfcsilt,ssfcwood,ssfpsand,ssfpsilt,ssfpwood,ssnother,ssvother,visit_no,hipwcrops,hipwdocks,hipwnonag,hipwroads,hipwwalls,l_rthzvrt,lmfpwoody,lmpwhuman,lrcvq_5aa,lrcvq_5ba,lrcvq_5ca,lrcvq_5da,lrcvq_6aa,lrcvq_6ba,lrcvq_6ca,lrcvq_6da,rdisinex1,rdisinex2,ssfcother,ssfpother,ssncobble,ssngravel,ssofclass,ssopclass,ssvcobble,ssvgravel,bffgradual,hiiagcirca,hinorchard,hinpasture,lmfpcobble,lmfplittle,lmfppatchy,rdisinex1a,rdisinex2a,rdislev_x1,rdislev_x2,ssfccobble,ssfcgravel,ssfpcobble,ssfpgravel,ssnbedrock,ssnorganic,ssvbedrock,ssvorganic,bffvertical,hiiallcirca,hinlandfill,hipworchard,hipwpasture,l_horizdist,lmfpbedrock,rdisinnonag,rdislev_x1a,rdislev_x2a,ssfcbedrock,ssfcorganic,ssfpbedrock,ssfporganic,ssnboulders,ssvboulders,bfnhorizdist,bfxhorizdist,flag_phabmet,hifpanycirca,hinbuildings,hipwlandfill,l_vertheight,lmfpboulders,lmnsubstrate,lmosubstrate,sampled_phab,ssfcboulders,ssfpboulders,bfnvertheight,bfxvertheight,hiinonagcirca,hincommercial,hinpowerlines,hipwbuildings,lmncovertypes,ssistavariety,hipwcommercial,hipwpowerlines,lmfpartificial,lmfpcontinuous,ssisitevariety,comment_phabmet,ssiststavariety} \
                                    , plankton_oemodel_analysisdata{otu_oe5,site_id,visit_no,abund_oe5,sample_category} \
                                    , waterquality{mg_ht,na_ht,h,k,ca,cl,mg,na,oh,anc,doc,nh4,no3,ntl,ptl,so4,toc,chla,cond,k_ht,sio2,sobc,turb,year,ca_ht,cl_ht,color,k_ppm,anc_ht,andef2,ansum2,ca_ppm,catsum,cl_ppm,doc_ht,k_flag,mg_ppm,na_ppm,nh4_ht,nh4ion,no3_ht,ntl_ht,orgion,ph_lab,ptl_ht,so4_ht,toc_ht,ca_flag,chla_ht,cl_flag,concal2,cond_ht,condho2,mg_flag,na_flag,no3_no2,ntl_ppm,sampled,secmean,sio2_ht,site_id,so4_ppm,turb_ht,anc_flag,balance2,color_ht,date_col,datechem,datechla,day_ship,doc_flag,nh4_flag,nh4n_ppm,no3_flag,no3n_ppm,ntl_flag,ph_field,phlab_ht,ptl_flag,so4_flag,toc_flag,visit_id,visit_no,cond_flag,lake_samp,no3no2_ht,sio2_flag,site_type,turb_flag,color_flag,datesecchi,k_ht_alert,k_rl_alert,phlab_flag,ca_ht_alert,ca_rl_alert,cl_ht_alert,cl_rl_alert,flag_secchi,lab_id_chem,lab_id_chla,mg_ht_alert,mg_rl_alert,na_ht_alert,na_rl_alert,no3no2_flag,anc_ht_alert,com_field_ph,doc_ht_alert,doc_rl_alert,nh4_ht_alert,nh4_rl_alert,no3_ht_alert,no3_rl_alert,ntl_ht_alert,ntl_rl_alert,ptl_ht_alert,ptl_rl_alert,sample_depth,sampled_chem,sampled_chla,so4_ht_alert,so4_rl_alert,toc_ht_alert,toc_rl_alert,chla_ht_alert,chla_rl_alert,cond_ht_alert,cond_rl_alert,date_filtered,date_received,dayship_alert,flag_fld_chla,flag_lab_chla,indxsamp_chem,indxsamp_chla,sio2_ht_alert,sio2_rl_alert,turb_ht_alert,turb_rl_alert,color_ht_alert,color_rl_alert,comment_secchi,datefilt_alert,ph_field_depth,phlab_ht_alert,sample_id_chem,sample_id_chla,sampled_secchi,clear_to_bottom,comment_im_chem,no3no2_ht_alert,no3no2_rl_alert,sample_category,comment_fld_chem,comment_fld_chla,comment_lab_chem,comment_lab_chla} \
                                } \
                              } \
                            }",
                    variables: {'site_id':site_id}
                })
                .then(function (response) { 
                    console.log(response.data);
                    successFunction(response.data.data.lake); 
                }, this.error);
            },

            getMeta: function(field_name, successFunction) {
                return $http.post('/queries', {
                    query: "query meta($field_name:String!) { \
                              meta(field_name: $field_name){ \
                                field_name,type,values \
                              } \
                            }",
                    variables: {'field_name':field_name}
                })
                .then(function (response) { 
                    var m = response.data.data.meta;
                    // the 'values' element comes as stringified json, unpack it
                    m.values = JSON.parse(m.values);
                    // map the counts (if available) into a more usable form 
                    if (m.values.counts) {
                        m.values.counts = m.values.counts.map(function(e){ 
                            return {label:e[0],value:e[1]} 
                        });
                    }
                    successFunction(response.data.data.meta); 
                }, this.error);
            }

        };

        return service;
    });