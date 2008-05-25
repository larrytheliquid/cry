require 'readline'
module Cry
  module LispMode  
    module CryMethods
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def require_rlisp(file_path)
          file_path << ".rlisp" unless file_path =~ /\.rlisp$/
          File.open(file_path) {|file| ParseTree.from_rlisp(file.read).evaluate }
        end
        
        # repl stolen from Bus Scheme: http://github.com/technomancy/bus-scheme/tree/master
        def repl
          loop do
            puts begin
                   input = Readline.readline('> ')
                   exit if input.nil? # only Ctrl-D produces nil here it seems
                   begin # allow for multiline input
                     result = ParseTree.from_rlisp(input).evaluate.inspect
                   end
                   Readline::HISTORY.push(input)
                   result
                 rescue Interrupt
                   'Type "exit" or press Ctrl-D to leave Cry.'
                 rescue StandardError => e
                   "You made me Cry =(\n" +
                     "#{e.class}: #{e}\n#{e.backtrace.join("\n")}"
                 end
          end
        end        
      end
    end
    
    module ObjectMethods
      def e(*args)
        ParseTree.new(*args).evaluate
      end
    end

    module ParseTreeMethods
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods      
        def from_rlisp(rlisp)
          rlisp_tokenize rlisp.scan(/[\(\)]|[^\s\)]+|\[\S*\]/)
        end

        def rlisp_tokenize(tokens, current_node = nil)
          while !tokens.empty? do
            case token = tokens.shift
            when "(" # new ParseTree, and next token is node method
              rlisp_node_method = tokens.shift
              rlisp_node_method.gsub!("-", "_") unless rlisp_node_method == "-"
              next_node = ParseTree.new(rlisp_node_method.to_sym)
              if current_node
                current_node << rlisp_tokenize(tokens, next_node)
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

      def to_rlisp
        parse_tree = []
        parse_tree << node_method.to_s.gsub("_", "-")
        parse_tree << (node_object.is_a?(ParseTree) ? node_object.to_rlisp : node_object.inspect)
        parse_tree << node_arguments.map{|a| a.is_a?(ParseTree) ? a.to_rlisp : a.inspect } unless node_arguments.empty?
        "(#{parse_tree.join(" ")})"
      end
    end
  end
end
# TODO: Extract LispMode into a separate project with a Cry submodule... named Crysp