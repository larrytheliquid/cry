require 'spec/rake/spectask'
require 'spec/translator'

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"spec/spec.opts\""]
  t.spec_files = FileList['spec/parse_tree/public/**/*_spec.rb', 'spec/parse_tree/private/**/*_spec.rb']
end

namespace :spec do
  desc "Run the specs under spec/parse_tree"
  Spec::Rake::SpecTask.new(:parse_tree) do |t|
    t.spec_opts = ['--options', "\"spec/spec.opts\""]
    t.spec_files = FileList['spec/parse_tree/public/**/*_spec.rb', 'spec/parse_tree/private/**/*_spec.rb']
  end
  
  namespace :parse_tree do |t|
    desc "Run the specs under spec/parse_tree/public"
    Spec::Rake::SpecTask.new(:public) do |t|
      t.spec_opts = ['--options', "\"spec/spec.opts\""]
      t.spec_files = FileList['spec/parse_tree/public/**/*_spec.rb']
    end
    
    desc "Run the specs under spec/parse_tree/private"
    Spec::Rake::SpecTask.new(:private) do |t|
      t.spec_opts = ['--options', "\"spec/spec.opts\""]
      t.spec_files = FileList['spec/parse_tree/private/**/*_spec.rb']
    end
  end
end
