require 'multi_site/engine'
TrustyCms.config do |config|
  # config.define "setting.name", :default => 'value', :select_from => ['foo', 'bar']
  require 'multi_site/scoped_validation'
end
