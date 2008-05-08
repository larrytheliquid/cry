module Cry
  module LispMode
    def cry_mode
      LispMode
    end
  
    def e(*args)
      ParseTree.new(*args).evaluate
    end
  end
end