require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'
require 'prmd/rake_tasks/doc'

schema_root = 'docs/schema'

namespace :schema do
  Prmd::RakeTasks::Combine.new do |t|
    t.options[:user] = "#{schema_root}/schemata/user.yml"
    t.options[:todo] = "#{schema_root}/schemata/todo.yml"
    t.paths << "#{schema_root}/schemata"
    t.output_file = "#{schema_root}/schema.json"
  end

  Prmd::RakeTasks::Verify.new do |t|
    t.files << "#{schema_root}/schema.json"
  end

  Prmd::RakeTasks::Doc.new do |t|
    t.files = { "#{schema_root}/schema.json" => "#{schema_root}/shcema.md"}
  end

end

desc 'Combine & Verify schema & Generate documentation'
task schema: ['schema:combine', 'schema:verify', 'schema:doc']
