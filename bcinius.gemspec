# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "bcinius"
  spec.version       = "1.0.0"
  spec.authors       = ["Franck Verrot"]
  spec.email         = ["franck@verrot.fr"]
  spec.summary       = %q{An implementation of the well-known `bc`, with Rubinius.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/franckverrot/bcinius"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest"
end
