require File.join(File.dirname(__FILE__), "lib", "parse_tree")
require File.join(File.dirname(__FILE__), "lib", "ruby_mode")
require File.join(File.dirname(__FILE__), "lib", "lisp_mode")

module Cry
  def self.mode
    @@mode if defined? @@mode
  end
  
  def self.mode=(mode)    
    if mode == LispMode
      Cry.send(:include, LispMode::CryMethods)
      Object.send(:include, LispMode::ObjectMethods)
      ParseTree.send(:include, LispMode::ParseTreeMethods)
    elsif mode == RubyMode
      # noop
    else
      raise Exception, "mode not recognized"
    end
    @@mode = mode    
  end
end

Cry.mode = Cry::RubyMode
# TODO: Update documentation to mention access to all of Array's methods, including Enumerable
# TODO: Update documentation to mention that everything is lazily evaluated, so you can manipulate it (similar to lambdas)
# TODO: Update documentation to mention that you can take out chunks and process them in parallel if you wanted to, as long as there are no side effect?