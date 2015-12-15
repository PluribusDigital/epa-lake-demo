class TypeMatch

  def self.analyze_set(set)
    type = self.guess(set)
    if ["boolean","category"].include? type 
      values = analyze_category(set)
    elsif ["int","float"].include? type
      values = analyze_numeric(set)
    elsif type == "string"
      values = analyze_string(set)
    else
      values = {}
    end
    {type:type,values:values}
  end

  def self.guess(set)
  	# expects array of data to check 
  	# i.e. feed it values from one column of data
    integer, float, bool_10, bool_tf, bool_yn, blank = true, true, true, true, true
    set.each do |i| 
      integer = false unless is_integer(i)
      float = false unless is_float(i)
      bool_10 = false unless is_bool(i,["1","0"])
      bool_tf = false unless is_bool(i,["true","false"])
      bool_yn = false unless is_bool(i,["yes","no"])
      blank = false unless i.blank?
    end
    return "blank" if blank
    return "boolean" if bool_10 || bool_tf || bool_yn
    if integer 
      return "category" if set.uniq.count < 6
      return "integer"
    end
    return "float" if float
    return "category" if set.uniq.count < 60
    return "string"
  end

  def self.is_integer(string)
    return true unless string # blanks shouldn't make false
    string.to_i.to_s == string
  end

  def self.is_float(string)
    return true unless string # blanks shouldn't make false
    # note: returns true for float-able, 
    #       including as integers "55"
    regex = /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
    (string =~ regex ) == 0 # returns nil if not floatable
  end

  def self.is_bool(string,bool_vals)
    return true unless string # blanks shouldn't make false
    bool_vals.include? string.downcase
  end

  def self.analyze_category(set)
    counts = {}
    set.each do |i| 
      # initialize or increment the count for this unique value
      counts[i].present? ? counts[i]+=1 : counts[i]=1
    end
    {counts:counts.sort_by{|c,v|v}.reverse}
  end

  def self.analyze_numeric(set)
    set = set.map{|e| is_float(e) ? e.to_f : nil }
    average = set.inject{ |sum, el| sum + el }.to_f / set.size
    {min:set.min, max:set.max, avg:average}
  end

  def self.analyze_string(set)
    counts = analyze_category(set)[:counts]
    {counts:counts[0..20], unique_values:set.uniq.count}
  end

end