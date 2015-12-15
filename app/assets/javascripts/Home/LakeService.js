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
                                st,sld,tnt,wgt,fid_1,huc_2,huc_8,panel,urban,com_id,lat_dd,lon_dd,mdcaty,repeat,rt_nla,sewage,area_ha,depth_x,elev_pt,epa_reg,fld_src,neslake,nhdname,nut_reg,sampled,site_id,stratum,wgt_nla,albers_x,albers_y,cntyname,date_col,depthmax,disposal,dsgn_cat,eco_nuta,fld_flag,lakearea,lakename,ref_nutr,visit_id,visit_no,wsa_eco3,wsa_eco9,area_cat7,eco_lev_3,evaporate,flag_info,lakeperim,lake_samp,reachcode,site_type,srfc_area,adjwgt_cat,aquacultur,eco_l3_nam,fld_lat_dd,fld_lon_dd,index_samp,meter_deep,neslake_id,non_saline,open_water,perm_water,phys_acces,size_class,state_name,status_dsk,status_fld,status_ver,lake_origin,nutreg_name,ref_cluster,sampled_inf,comment_info,indxsamp_inf,refclus_name,sampled_chem,sampled_chla,sampled_core,sampled_ente,sampled_micr,sampled_phab,sampled_phyt,sampled_sdhg,sampled_zoop,eco3_x_origin,indxsamp_chem,indxsamp_chla,indxsamp_core,indxsamp_ente,indxsamp_micr,indxsamp_phab,indxsamp_phyt,indxsamp_sdhg,indxsamp_zoop,sampled_assess,sampled_secchi,sampled_profilew \
                              } \
                            }",
                    variables: {'site_id':site_id}
                })
                .then(function (response) { console.log(response.data);successFunction(response.data.data.lake); }, this.error);
            }

        };

        return service;
    });