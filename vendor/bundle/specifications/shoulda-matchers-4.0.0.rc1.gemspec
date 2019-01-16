# -*- encoding: utf-8 -*-
# stub: shoulda-matchers 4.0.0.rc1 ruby lib

Gem::Specification.new do |s|
  s.name = "shoulda-matchers"
  s.version = "4.0.0.rc1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tammer Saleh", "Joe Ferris", "Ryan McGeary", "Dan Croak", "Matt Jankowski", "Stafford Brunk", "Elliot Winkler"]
  s.date = "2018-10-02"
  s.description = "Making tests easy on the fingers and eyes"
  s.email = "support@thoughtbot.com"
  s.executables = ["setup"]
  s.files = ["bin/setup"]
  s.homepage = "https://matchers.shoulda.io/"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0")
  s.rubygems_version = "2.5.1"
  s.summary = "Making tests easy on the fingers and eyes"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 4.2.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 4.2.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 4.2.0"])
  end
end
