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

  s.add_development_dependency 'rubocop', '~> 0.20.1'
  s.add_development_dependency 'rake', '~> 10.3.0'
  s.add_development_dependency 'coveralls', '~> 0.7.0'
  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'fuubar', '~> 1.3.2'
end