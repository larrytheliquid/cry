require File.join(File.dirname(__FILE__), "lib", "parse_tree")
require File.join(File.dirname(__FILE__), "lib", "ruby_mode")
require File.join(File.dirname(__FILE__), "lib", "lisp_mode")

module Cry
  def self.mode
    @@mode if defined? @@mode
  end
  
  def self.mode=(mode)
    Object.send(:include, mode)
    ParseTree.send(:include, LispParseTree) if mode == LispMode
    @@mode = mode    
  end
end

Cry.mode = Cry::RubyMode