require 'multi_site/engine'
TrustyCms.config do |config|
  # config.define "setting.name", :default => 'value', :select_from => ['foo', 'bar']
  ApplicationController.send :include, MultiSite::ApplicationControllerFilterExtensions
  require 'multi_site/scoped_validation'
end
