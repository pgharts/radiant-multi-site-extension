require 'multi_site/engine'

Admin::LayoutsController.send :helper, MultiSite::SiteChooserHelper
Admin::SnippetsController.send :helper, MultiSite::SiteChooserHelper

TrustyCms.config do |config|
  # config.define "setting.name", :default => 'value', :select_from => ['foo', 'bar']
  require 'multi_site/scoped_validation'
end
