require 'rubygems'
require 'bundler'

Bundler::GemHelper.install_tasks

desc 'Delete all built gems inside pkg directory'
task :clean do
  require 'fileutils'

  Dir.glob(File.join(File.dirname(__FILE__), 'pkg', '*.gem')).each do |file|
    FileUtils.rm file
    puts "Removed #{File.basename(file)}"
  end
end
