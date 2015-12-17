require 'spec_helper'

RSpec.describe TypeMatch do

  describe "data type guessing" do 

  	it "should guess categorical type when < 6 unique integer values" do 
  		data = ["1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2","1","2"]
  		expect( TypeMatch.guess(data) ).to eq "category"
  	end

  	it "should guess categorical type when < 20 unique string values" do 
  		data = ["NO CORE SAMPLE", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "NO CORE SAMPLE", "YES", "YES (LOST SAMPLE)", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "NO CORE SAMPLE", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "NO CORE SAMPLE", "NO CORE SAMPLE", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "NOT DONE", "NO CORE SAMPLE", "YES", "NO LAB DATA", "NOT DONE", "YES", "NO LAB DATA", "NO LAB DATA", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "YES", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NO LAB DATA", "NO LAB DATA", "NO LAB DATA", "NOT DONE", "NOT DONE", "NOT DONE", "YES", "NOT DONE", "NOT DONE", "NOT DONE", "NOT DONE", "NO LAB DATA", "YES (LOST SAMPLE)", "YES", "NO LAB DATA", "NO LAB DATA"]
  		expect( TypeMatch.guess(data) ).to eq "category"
  	end

	it "should guess integer type when many unique integer digits" do 
  		data = ["10","3","3","12","12","14","14","17","17","1","1","7","7","7","7","4","4","11","11","2","2","9","9","13","13","10","10","10","10","5","5","4","4","12","12","12","12","3","3","2","2","5","5","17","17","5","5","1","1","1","1","5","5","10","10","4","4","10","10","2","2","8","8","17","1","1","2","2","3","3","15","15","10","10","10","10","17","17","5","5","14","14","3","3","8","8","12","12","16","16","10","10","2","2","9","9","14","14","8"]
  		expect( TypeMatch.guess(data) ).to eq "integer"
  	end

  	it "should guess float type when many unique float digits" do 
  		data = ["48.98348", "33.03571", "33.035681", "28.0475", "28.0475", "37.41783", "37.41791", "43.92898", "43.92903", "41.67626", "41.67644", "45.581111", "45.580556", "41.2928", "41.29268", "42.62049", "42.62058", "35.99915", "35.99935", "39.972894", "39.972744", "47.83361", "47.83524", "32.90688", "32.90683", "41.0383", "41.03878", "46.366667", "46.36623", "39.410833", "39.411111", "42.82747", "42.83111", "31.1489", "31.14894", "32.07322", "32.071433", "35.201583", "35.20118", "38.75662", "38.75643", "39.776322", "39.77637", "47.310642", "47.310646", "37.477222", "37.477222", "41.69141", "41.69141", "44.8075", "44.807554", "38.21106"]
  		expect( TypeMatch.guess(data) ).to eq "float"
  	end

  	it "should guess string type when many unique strings" do 
  		data = ["Amistad Reservoir", "Anawana Lake", "Anderson Lake", "Angel Lake", "Antelope Lake", "Apache Lake", "Argonne Lake", "Arkabutla Lake", "Armington Lake", "Armstrong Lake", "Armstrong Lake", "Arrow Tank", "Arrowhead Lake", "Arrowrock Reservoir", "Arthur Lake", "Artichoke Lake", "Ashley Lake", "Ashley Lake", "Ashton Reservoir", "Ashurst", "Aspen Lake", "Atkins Lake", "Atwood Lake", "August Lake", "Aurora Pond", "Baca Lake", "Back Lake", "Badger Creek Lake", "Bald Run Reservoir", "Banks Lake", "Barbara Lake", "Barker Reservoir", "Barrs Chapel Lake", "Bass Lake", "Bass Lake", "Bass Lake", "Bassett Lake", "Bayley", "Bayou D'Arbonne Lake", "Beach Pond", "Bean Lake", "Beardsley Pond", "Beaver Dam Reservoir", "Beaver Lake", "Beaver Pond", "Beaver Pond", "Beaver Run Reservoir", "Beaverdale Reservoir", "Beaverdam Lake", "Becker Lake", "Becoosin Lake", "Bee Creek Lake", "Beebe Lake", "Belleville Lake", "Belleville Pond", "Belmont Lake", "Beltzville Lake", "Bentley Lake", "Berry Lake", "Beulah Reservoir", "Bieri Lake Number 3", "Big Alkali Lake", "Big Barbee Lake", "Big Battlement Lake", "Big Chapman", "Big Gibson Lake", "Big Lake", "Big Lake", "Big Reed Pond", "Big Sand Wash", "Big Sandy Reservoir", "Big Spring Reservoir", "Big Stone Lake", "Bighorn Lake", "Birch Creek Reservoir Number 2", "Birch Lake", "Birdbath Lake", "Birdbath Lake", "Bischoff Reservoir", "Bissonnette Pond", "Black Lake", "Black Lake", "Blackfish Lake", "Blackman Lake", "Blacks Creek Reservoir", "Blacks Creek Reservoir", "Blanchard Lake", "Blomgren", "Blue Lake", "Blue Lake", "Blue Lake", "Blue Ridge", "Blue Ridge Lake", "Blueberry Lake", "Bluestem Lake", "Boatwright Farm Pond", "Boca Reservoir", "Bogie Lake", "Bogie Lake", "Boley Lake", "Boulder Reservoir", "Bowdish Reservoir", "Box Butte Reservoir", "Boyd Lake", "Boysen Reservoir", "Branched Oak Lake", "Brant Lake", "Braunig Lake", "Breckinridge Reservoir", "Bridge Lake", "Brierpatch Lake", "Brooklyn Lake", "Browns Lake", "Bruce Lake", "Brush Hollow Reservoir", "Brush Lake", "Buchanan Lake", "Buckley-Dunton", "Buckskin Lake", "Buffalo Lodge Lake", "Bull Lake", "Bull Trout Lake", "Bullock Pen Lake", "Bunkick Lake", "Burgess Falls Lake", "Bushwacker", "Button Rock Reservoir", "Caballo Reservoir", "Caballo Reservoir"]
  		expect( TypeMatch.guess(data) ).to eq "string"
  	end  	

    it "should guess boolean type when yes/no" do 
      data = ["YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO","YES", "NO"]
      expect( TypeMatch.guess(data) ).to eq "boolean"
    end

    it "should guess boolean type when true/false" do 
      data = ["True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False","True","False"]
      expect( TypeMatch.guess(data) ).to eq "boolean"
    end

    it "should guess boolean type when 1/0" do 
      data = ["0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1","0","1"]
      expect( TypeMatch.guess(data) ).to eq "boolean"
    end

  end

end


