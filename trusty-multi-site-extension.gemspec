# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trusty-multi-site-extension"

Gem::Specification.new do |s|
  s.name        = "trusty-multi-site-extension"
  s.version = "1.0.0"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Sipple"]
  s.date = %q{2014-10-07}
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
  s.add_dependency "acts_as_list", "0.4.0"
  s.add_dependency "trusty-snippets-extension"
end
