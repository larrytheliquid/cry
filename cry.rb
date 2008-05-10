require File.join(File.dirname(__FILE__), "lib", "parse_tree")
require File.join(File.dirname(__FILE__), "lib", "ruby_mode")
require File.join(File.dirname(__FILE__), "lib", "lisp_mode")

module Cry
  def self.mode
    @@mode if defined? @@mode
  end
  
  def self.mode=(mode)
    Object.send(:include, mode)
    @@mode = mode    
  end
end
# TODO: Undefine and redefine Object#cry_mode when changing modes