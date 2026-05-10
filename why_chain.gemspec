# frozen_string_literal: true

require_relative "lib/why_chain/version"

Gem::Specification.new do |spec|
  spec.name = "why_chain"
  spec.version = WhyChain::VERSION
  spec.authors = ["alessio salati"]
  spec.email = ["alessio.salati@gmail.com"]

  spec.summary = "Inspect Ruby method dispatch at runtime."
  spec.description = "WhyChain is a tiny educational gem to inspect lookup chain, " \
                     "method owner, and next super target in Ruby."
  spec.homepage = "https://github.com/alessio-salati/why_chain"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alessio-salati/why_chain"
  spec.metadata["changelog_uri"] = "https://github.com/alessio-salati/why_chain/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor]) ||
        f.end_with?(".gem")
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
