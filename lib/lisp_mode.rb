module Cry
  module LispMode  
    def e(*args)
      ParseTree.new(*args).evaluate
    end
  end
  
  module LispParseTree
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def from_lisp(lisp)
        lisp_tokenize lisp.scan(/[\(\)]|[^\s\)]+|\[\S*\]/)
      end
      
      def lisp_tokenize(tokens, current_node = nil)
        while !tokens.empty? do
          case token = tokens.shift
          when "(" # new ParseTree, and next token is node method
            next_node = ParseTree.new(tokens.shift.gsub("-", "_").to_sym)
            if current_node
              current_node << lisp_tokenize(tokens, next_node)
            else
              current_node = next_node
            end
          when ")" # end ParseTree
            return current_node
          else # node object or argument
            current_node << eval(token)
          end
        end
      end
    end
    
    def to_lisp
      "(#{node_method} #{node_object.is_a?(ParseTree) ? node_object.to_lisp : node_object.inspect} #{node_arguments.map{|a| a.is_a?(ParseTree) ? a.to_lisp : a.inspect }})"
    end
  end
end
# TODO: Cry.require_lisp
# TODO: script/cry