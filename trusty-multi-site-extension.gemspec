# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trusty-multi-site-extension"

Gem::Specification.new do |s|
  s.name        = "trusty-multi-site-extension"
  s.version = "3.0.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sean Cribbs", "Eric Sipple", "Danielle Greaves", "Brittany Martin"]
  s.description = %q{Extends Trusty CMS Layouts to support multiple sites, defined by domain}
  s.email = %q{sipple@trustarts.org}
  s.homepage = %q{https://github.com/pgharts/trusty-multi-site-extension}
  s.summary = %q{Extends Trusty CMS Layouts to support multiple sites, defined by domain}

  ignores = if File.exist?('.gitignore')
              File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
            else
              []
            end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
  s.add_dependency "acts_as_list", "0.9.5"
  s.add_dependency "trusty-snippets-extension", "~> 3.1.0"
  s.add_dependency "trusty-cms",   "~> 3.1.0"
  s.add_dependency "rake",         "< 11.0"
end
