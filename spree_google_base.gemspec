Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_google_base'
  s.version     = '0.30.1'
  s.summary     = 'Google Base for Spree'
  s.description = 'Provide rake task to generate XML for Google Base and so on.'
  s.required_ruby_version = '>= 1.8.7'

  s.authors     = ['Steph Skardal', 'Ryan Siddle', 'Roman Smirnov']
  # s.email             = 'david@loudthinking.com'
  s.homepage          = 'http://github.com/romul/spree-google-base'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.30.1')
end
