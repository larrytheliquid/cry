module Cry
  class ParseTree < Array
    def initialize(*args)
      super args.to_ary
    end
  
    def evaluate
      evaluated_node_object = evaluate_node(node_object)
      raw_send_arguments = node_arguments.map{|argument| evaluate_node(argument) }.insert(0, node_method)
      evaluated_node_object.send *raw_send_arguments
    rescue ArgumentError => original_error
      begin
        standard_send_arguments = raw_send_arguments
        block_send_argument = raw_send_arguments.pop
        evaluated_node_object.send *standard_send_arguments, &block_send_argument
      rescue Exception
        raise original_error
      end
    end
  
    def node_method
      self.first.to_sym unless empty?
    end
  
    def node_method=(node_method)
      self[0] = node_method.to_sym
    end
  
    def node_object
      self[1] unless size < 2
    end
  
    def node_object=(node_object)
      self[1] = node_object
    end
  
    def node_arguments
      size >= 2 ? self[2..size].to_a : Array.new
    end
  
    def node_arguments=(node_arguments)
      self[2..size] = node_arguments
    end
  
    def height
      (node_method ? 1 : 0) + self[1..size].to_a.map{|node| node.is_a?(ParseTree) ? node.height : 1 }.max.to_i
    end
  
    def inspect
      super.sub(/^\[/, "(").sub(/\]$/, ")")
    end
    alias_method :to_s, :inspect
  
  private
  
    def evaluate_node(node)
      node.is_a?(ParseTree) ? (node.node_method ? node.evaluate : nil) : node if node
    end
  end
end