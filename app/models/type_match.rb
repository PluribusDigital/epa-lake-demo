class TypeMatch

  def self.guess(set)
  	# expects array of data to check 
  	# i.e. feed it values from one column of data
    integer = true
    float = true
    set.each do |i| 
      integer = false unless isInteger(i)
      float = false unless isFloat(i)
    end
    if integer 
      return "category" if set.uniq.count < 6
      return "integer"
    end
    return "category" if set.uniq.count < 20
    return "float" if float
    return "string"
  end

  def self.isInteger(string)
    string.to_i.to_s == string
  end

  def self.isFloat(string)
    # note: returns true for float-able, 
    #       including as integers "55"
    regex = /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
    (string =~ regex ) == 0 # returns nil if not floatable
  end

end