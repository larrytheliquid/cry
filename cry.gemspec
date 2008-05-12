Gem::Specification.new do |s|
  s.name = "cry"
  s.version = "0.0.1"
  s.date = "2008-05-11"
  s.summary = "An easy to use Ruby parse tree. Also has extensions to be able to write Ruby code in Lisp syntax."
  s.email = "larrytheliquid@gmail.com"
  s.homepage = "http://github.com/larrytheliquid/cry/tree/master"
  s.description = "A CommonLisp CLOS-like ParseTree in Ruby... read it and weep."
  s.has_rdoc = true
  s.authors = ["Larry Diehl (larrytheliquid)"]
  s.files = ["README.rdoc", "cry.rb", "lib/lisp_mode.rb", "lib/parse_tree.rb", "ruby_mode.rb", "MIT-LICENSE", "spec/cry_spec.rb", "spec/fixtures/example.rlisp", "spec/lisp_mode_spec.rb", "spec/parse_tree_spec.rb", "spec/ruby_mode_spec.rb"]
  s.test_files = ["spec/cry_spec.rb", "spec/fixtures/example.rlisp", "spec/lisp_mode_spec.rb", "spec/parse_tree_spec.rb", "spec/ruby_mode_spec.rb"]
  s.rdoc_options = ["--main", "README.rdoc"]
end