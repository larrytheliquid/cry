module Cry
  module LispMode  
    def e(*args)
      ParseTree.new(*args).evaluate
    end
  end
  
  module LispParseTree
    def to_lisp
      "(#{node_method} #{node_object.is_a?(ParseTree) ? node_object.to_lisp : node_object.inspect} #{node_arguments.map{|a| a.is_a?(ParseTree) ? a.to_lisp : a.inspect }})"
    end
  end
end
# TODO: ParseTree.from_lisp