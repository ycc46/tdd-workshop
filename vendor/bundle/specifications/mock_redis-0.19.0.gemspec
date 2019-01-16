# -*- encoding: utf-8 -*-
# stub: mock_redis 0.19.0 ruby lib

Gem::Specification.new do |s|
  s.name = "mock_redis"
  s.version = "0.19.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brigade Engineering", "Samuel Merritt"]
  s.date = "2018-08-03"
  s.description = "Instantiate one with `redis = MockRedis.new` and treat it like you would a normal Redis object. It supports all the usual Redis operations."
  s.email = ["eng@brigade.com"]
  s.homepage = "https://github.com/brigade/mock_redis"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2")
  s.rubygems_version = "2.5.1"
  s.summary = "Redis mock that just lives in memory; useful for testing."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["< 12", ">= 10"])
      s.add_development_dependency(%q<redis>, ["~> 3.3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-its>, ["~> 1.0"])
    else
      s.add_dependency(%q<rake>, ["< 12", ">= 10"])
      s.add_dependency(%q<redis>, ["~> 3.3.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rspec-its>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rake>, ["< 12", ">= 10"])
    s.add_dependency(%q<redis>, ["~> 3.3.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rspec-its>, ["~> 1.0"])
  end
end
