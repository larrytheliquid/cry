module Cry
  module LispMode  
    def e(*args)
      ParseTree.new(*args).evaluate
    end
  end
end
# TODO: ParseTree.from_lisp
# TODO: ParseTree#to_lisp