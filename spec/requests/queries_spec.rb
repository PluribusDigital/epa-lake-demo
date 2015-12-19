require 'spec_helper'

RSpec.describe "Queries API" do

  before :each do 
    # Lake.all.limit(10).each{|l| puts "Lake.create(file: '#{l.file}', site_id: '#{l.site_id}', visit_no: 1, data: {'ST'=>\'#{l.data['ST']}\','LAKENAME'=>\'#{l.data['LAKENAME']}\','CNTYNAME'=>\'#{l.data['CNTYNAME']}\'})"}
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0044', visit_no: 1, data: {'site_id'=>'NLA06608-0044','st'=>'NE','lakename'=>'Steverson Lake','cntyname'=>'CHERRY'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0045', visit_no: 1, data: {'site_id'=>'NLA06608-0045','st'=>'VA','lakename'=>'Beaver Pond','cntyname'=>'AMELIA'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0048', visit_no: 1, data: {'site_id'=>'NLA06608-0048','st'=>'MO','lakename'=>'Nolen Blue Hole','cntyname'=>'MISSISSIPPI'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0049', visit_no: 1, data: {'site_id'=>'NLA06608-0049','st'=>'OR','lakename'=>'Clear Creek Reservoir','cntyname'=>'BAKER'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0050', visit_no: 1, data: {'site_id'=>'NLA06608-0050','st'=>'NH','lakename'=>'Adder Pond','cntyname'=>'MERRIMACK'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0053', visit_no: 1, data: {'site_id'=>'NLA06608-0053','st'=>'NY','lakename'=>'South Bay Lake Champlain','cntyname'=>'ESSEX'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0057', visit_no: 1, data: {'site_id'=>'NLA06608-0057','st'=>'NC','lakename'=>'Lake Lee','cntyname'=>'UNION'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0061', visit_no: 1, data: {'site_id'=>'NLA06608-0061','st'=>'AZ','lakename'=>'Alamo','cntyname'=>'MOHAVE'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0062', visit_no: 1, data: {'site_id'=>'NLA06608-0062','st'=>'ND','lakename'=>'(Unnamed Lake)','cntyname'=>'KIDDER'})
    LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0064', visit_no: 1, data: {'site_id'=>'NLA06608-0064','st'=>'MT','lakename'=>'Fitzpatrick Lake','cntyname'=>'TOOLE'})
  end

  describe "searching lakes" do

    it "provides search results on a substring" do
      q = "query search($searchString:String!) {lakes(search_string: $searchString){site_id,lakename,cntyname,st}}"
      v = {'searchString'=>'lake'}
      params = {query:q, variables:v}
      post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
      expect(json["data"]["lakes"].length).to eq 5
    end

    it "matches on site_id" do
      q = "query search($searchString:String!) {lakes(search_string: $searchString){site_id,lakename,cntyname,st}}"
      v = {'searchString'=>'0049'}
      params = {query:q, variables:v}
      post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
      expect(json["data"]["lakes"].length).to eq 1
    end

  end

  describe "getting lake data from related file" do

    before :each do 
      LakeData.create(site_id:'NLA06608-0050',visit_no:1,file:'PHab_Metrics_A',data:{'bsFoil'=>0.01})
      LakeData.create(site_id:'NLA06608-0050',visit_no:2,file:'PHab_Metrics_A',data:{'bsFoil'=>0.02})
    end

    # it "gets PHab_Metrics_A data for a visit" do 
    #   q = "query lakeFileData($site_id:ID!,$file:String!,$visit_no:String!) {lake_file_data(site_id: $site_id, file: $file, visit_no: $visit_no){field,value}}"
    #   v = {
    #     'site_id'=>'NLA06608-0050',
    #     'visit_no'=>2,
    #     'file'=>'PHab_Metrics_A'
    #   }
    #   params = {query:q, variables:v}
    #   post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
    #   expect(json["data"]["lake_file_data"].first["field"]).to eq "foo"
    # end 

    it "gets PHab_Metrics_A data via the visit" do 
      q = "query search($searchString:String!) {lakes(search_string: $searchString){site_id,lakename,cntyname,st,visits{visit_no,phab_metrics_a{bsfoil}}}}"
      v = {'searchString'=>'NLA06608-0050'}
      params = {query:q, variables:v}
      post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
      expect(json["data"]["lakes"].length).to eq 1
    end

  end

  describe "reading field meta data" do 

    before :each do 
      # LakeDataField.all.limit(10).each{|f| puts "LakeDataField.create(file: '#{f.file}', field_name: '#{f.field_name}', data: '#{f.data}')"}
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'YEAR', data: '{"type"=>"category", "values"=>"{:counts=>[[\"2007\", 1442]]}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'amnAll', data: '{"type"=>"integer", "values"=>"{}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'amvAll', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>0.461451514, :avg=>0.1640590610644937}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'bsfH2S', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>1.0, :avg=>0.059537268864771176}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'bsfOil', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>0.2, :avg=>0.001687471104715673}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'bsfRed', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>1.0, :avg=>0.012053089842579743}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'fciAll', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>1.678333333, :avg=>0.46131437506518785}"}')
      LakeDataField.create(file: 'PHab_Metrics_A', field_name: 'fciBig', data: '{"type"=>"float", "values"=>"{:min=>0.0, :max=>1.28, :avg=>0.13620486521359215}"}')
    end

    it "provides data for the lakename field" do
      q = "query meta($field_name:String!) {meta(field_name: $field_name){field_name,type,values}}"
      v = {'field_name'=>'YEAR'}
      params = {query:q, variables:v}
      post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}
      expect(json["data"]["meta"]).to be_present
    end

    it "provides numeric stats for the amvAll field" do
      q = "query meta($field_name:String!) {meta(field_name: $field_name){field_name,type,values}}"
      v = {'field_name'=>'amvAll'}
      params = {query:q, variables:v}
      post "/queries", params.to_json, {'ACCEPT' => "application/json", 'CONTENT_TYPE' => 'application/json'}      
      values = json['data']['meta']['values']
      expect(JSON.parse(values)['max']).to be_a Float
    end 

  end

end
