Gem::Specification.new do |s|
  s.name = "Cry"
  s.version = "0.0.2"
  s.date = "2008-06-04"
  s.summary = "A lazily evaluated and easy to use Ruby parse tree."
  s.email = "larrytheliquid@gmail.com"
  s.homepage = "http://github.com/larrytheliquid/cry/tree/master"
  s.description = "A CommonLisp CLOS-like ParseTree in Ruby... read (and write) it and weep."
  s.has_rdoc = true
  s.authors = ["Larry Diehl (larrytheliquid)"]
  s.files = ["README.rdoc", "Rakefile", "cry.rb", "lib/parse_tree.rb", "MIT-LICENSE", "spec/parse_tree/public/evaluate_spec.rb", "spec/parse_tree/public/height_spec.rb", "spec/parse_tree/public/inspect_spec.rb", "spec/parse_tree/public/new_spec.rb", "spec/parse_tree/public/node_arguments_spec.rb", "spec/parse_tree/public/node_method_spec.rb", "spec/parse_tree/public/node_object_spec.rb", "spec/parse_tree/private/evaluate_node_spec.rb", "spec/spec.opts"]
  s.test_files = ["spec/parse_tree/public/evaluate_spec.rb", "spec/parse_tree/public/height_spec.rb", "spec/parse_tree/public/inspect_spec.rb", "spec/parse_tree/public/new_spec.rb", "spec/parse_tree/public/node_arguments_spec.rb", "spec/parse_tree/public/node_method_spec.rb", "spec/parse_tree/public/node_object_spec.rb", "spec/parse_tree/private/evaluate_node_spec.rb", "spec/spec.opts"]
  s.rdoc_options = ["--main", "README.rdoc"]
end