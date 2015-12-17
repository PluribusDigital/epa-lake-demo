require 'spec_helper'

RSpec.describe "Queries API" do

  describe "searching lakes" do

    before :each do 
      # Lake.all.limit(10).each{|l| puts "Lake.create(file: '#{l.file}', site_id: '#{l.site_id}', visit_no: 1, data: {'ST'=>\'#{l.data['ST']}\','LAKENAME'=>\'#{l.data['LAKENAME']}\','CNTYNAME'=>\'#{l.data['CNTYNAME']}\'})"}
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0044', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0044','ST'=>'NE','LAKENAME'=>'Steverson Lake','CNTYNAME'=>'CHERRY'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0045', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0045','ST'=>'VA','LAKENAME'=>'Beaver Pond','CNTYNAME'=>'AMELIA'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0048', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0048','ST'=>'MO','LAKENAME'=>'Nolen Blue Hole','CNTYNAME'=>'MISSISSIPPI'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0049', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0049','ST'=>'OR','LAKENAME'=>'Clear Creek Reservoir','CNTYNAME'=>'BAKER'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0050', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0050','ST'=>'NH','LAKENAME'=>'Adder Pond','CNTYNAME'=>'MERRIMACK'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0053', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0053','ST'=>'NY','LAKENAME'=>'South Bay Lake Champlain','CNTYNAME'=>'ESSEX'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0057', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0057','ST'=>'NC','LAKENAME'=>'Lake Lee','CNTYNAME'=>'UNION'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0061', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0061','ST'=>'AZ','LAKENAME'=>'Alamo','CNTYNAME'=>'MOHAVE'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0062', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0062','ST'=>'ND','LAKENAME'=>'(Unnamed Lake)','CNTYNAME'=>'KIDDER'})
      LakeData.create(file: 'SampledLakeInformation', site_id: 'NLA06608-0064', visit_no: 1, data: {'SITE_ID'=>'NLA06608-0064','ST'=>'MT','LAKENAME'=>'Fitzpatrick Lake','CNTYNAME'=>'TOOLE'})
    end

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
