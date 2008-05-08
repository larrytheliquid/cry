class ParseTree < Array
  def initialize(*args)
    super(args.to_ary)
  end
  
  def evaluate
    evaluate_node_object.send( *([node_method] + evaluate_node_arguments) )
  end
  
  def node_method
    self.first.to_sym unless empty?
  end
  
  def node_object
    self[1] unless size < 2
  end
  
  def evaluate_node_object
    node_object.is_a?(ParseTree) ? node_object.evaluate : node_object if node_object
  end
  
  def node_arguments
    size >= 2 ? self[2..size] : []
  end
  
  def evaluate_node_arguments
    node_arguments.map{|argument| argument.is_a?(ParseTree) ? argument.evaluate : argument }
  end
end