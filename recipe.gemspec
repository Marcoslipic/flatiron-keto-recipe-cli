
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "recipe/version"

Gem::Specification.new do |spec|
  spec.name          = "recipe"
  spec.version       = Recipe::VERSION
  spec.authors       = ["mjroose"]
  spec.email         = ["mjroose@gmail.com"]

  spec.summary       = %q{Ketogenic Recipe CLI Gem}
  spec.description   = %q{Program that lets user browse recipes from KetoConnect.net from the command line.}
  spec.homepage      = "https://github.com/mjroose/flatiron-keto-recipe-cli"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "0.11"
  
  spec.add_dependency "nokogiri", "~> 1.6"
end
