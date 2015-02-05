Gem::Specification.new do |s|
  s.name        = 'gosu_lighting'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "Simple vector-based lighting for Gosu"
  s.description = "Vector-based shadows for circles and axis-aligned rectangles in the Gosu graphics library."
  s.authors     = ["Daniel Smith"]
  s.email       = 'jellymann@gmail.com'
  s.files       = ["lib/gosu_lighting.rb"]
  s.homepage    = 'https://github.com/jellymann/gosu_lighting'

  s.add_runtime_dependency 'gosu', '~> 0.8'
  s.add_runtime_dependency 'opengl-bindings'
  s.add_runtime_dependency 'ffi'

  s.add_development_dependency 'rspec', '~> 3.0'
end
