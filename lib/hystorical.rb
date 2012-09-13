class Hystorical

  VERSION = "0.0.1.alpha"
  
  def self.delegate_class
    RubyHystorical
    # add conditional to determine which subclass to use once other strategies are used (i.e. ActiveRecord)
  end
end
