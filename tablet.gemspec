Gem::Specification.new do |s|
  s.name        = 'tablet'
  s.version     = '0.0.1'
  s.date        = Time.now.strftime("%Y-%m-%d")

  s.summary     = ''
  s.description = ""
  s.authors     = ['Les Aker']
  s.email       = 'me@lesaker.org'
  s.homepage    = 'https://github.com/akerl/tablet'
  s.license     = 'MIT'

  s.files       = `git ls-files`.split
  s.test_files  = `git ls-files spec/*`.split

  s.add_dependency 'cymbal', '~> 1.0.0'
  s.add_dependency 'highline', '~> 1.7.0'

  s.add_development_dependency 'rubocop', '~> 0.41.1'
  s.add_development_dependency 'rake', '~> 11.2.0'
  s.add_development_dependency 'coveralls', '~> 0.8.0'
  s.add_development_dependency 'rspec', '~> 3.5.0'
  s.add_development_dependency 'fuubar', '~> 2.1.0'
end
