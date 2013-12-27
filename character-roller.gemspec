Gem::Specification.new do |s|
  s.name     = "character-roller"
  s.version  = File.read File.join(File.dirname(__FILE__), 'VERSION')
  s.summary  = "Random d20 character ability score generator and dice roller"
  s.author   = "Mike Green"
  s.email    = "mike.is.green@gmail.com"
  s.license  = "MIT"
  s.platform = Gem::Platform::RUBY
  s.bindir   = 'bin'
  s.files    = %w(
    VERSION
    Rakefile
    character-roller.gemspec
  )
  s.files   += Dir.glob("bin/**/*")
  s.files   += Dir.glob("lib/**/*")

  s.description = <<-END_DESC
    A Thor-based CLI script for generating d20 character ability scores randomly.
  END_DESC

  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_development_dependency "watson"

  s.add_runtime_dependency "thor"
end
