class TypeMatch

  def self.guess(set)
  	# expects array of data to check 
  	# i.e. feed it values from one column of data
    integer, float, bool_10, bool_tf, bool_yn = true, true, true, true, true
    set.each do |i| 
      integer = false unless is_integer(i)
      float = false unless is_float(i)
      bool_10 = false unless is_bool(i,["1","0"])
      bool_tf = false unless is_bool(i,["true","false"])
      bool_yn = false unless is_bool(i,["yes","no"])
    end
    return "boolean" if bool_10 || bool_tf || bool_yn
    if integer 
      return "category" if set.uniq.count < 6
      return "integer"
    end
    return "float" if float
    return "category" if set.uniq.count < 20
    return "string"
  end

  def self.is_integer(string)
    string.to_i.to_s == string
  end

  def self.is_float(string)
    # note: returns true for float-able, 
    #       including as integers "55"
    regex = /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
    (string =~ regex ) == 0 # returns nil if not floatable
  end

  def self.is_bool(string,bool_vals)
    bool_vals.include? string.downcase
  end

end