require File.join(File.dirname(__FILE__), "lib", "parse_tree")
require File.join(File.dirname(__FILE__), "lib", "ruby_mode")
require File.join(File.dirname(__FILE__), "lib", "lisp_mode")

class Cry
  def self.mode
    class_variable_defined?(:@@mode) ? @@mode : RubyMode
  end
  
  def self.mode=(mode)
    @@mode = mode
    Object.extend(mode)
  end
end

class Object
  def self.cry_mode
    Cry.mode
  end
end