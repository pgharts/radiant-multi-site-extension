require_dependency 'application_controller'

class MultiSiteExtension < TrustyCms::Extension
  version "1.0.0"
  description %{ Enables virtual sites to be created with associated domain names.
                 Also scopes the sitemap view to any given page (or the root of an
                 individual site) and allows model classes to be scoped by site. }
  url "http://trustarts.org/"


  def activate
    # ActionController::Routing modules are required rather than sent as includes
    # because the routing persists between dev. requests and is not compatible
    # with multiple alias_method_chain calls.
    require 'multi_site/route_extensions'
    require 'multi_site/route_set_extensions'
    
    # likewise for ScopedValidation, which is a pre-emptive hack that shouldn't run more than once.


    # Model extensions
    ActiveRecord::Base.send :include, MultiSite::ScopedModel
    Page.send :include, MultiSite::PageExtensions

    # Controller extensions
    ApplicationController.send :include, MultiSite::ApplicationControllerExtensions
    Admin::ResourceController.send :include, MultiSite::ApplicationControllerExtensions
    #ActionController::Base.send :include, MultiSite::ApplicationControllerExtensions
    SiteController.send :include, MultiSite::SiteControllerExtensions
    Admin::ResourceController.send :include, MultiSite::ResourceControllerExtensions
    Admin::PagesController.send :include, MultiSite::PagesControllerExtensions
    Admin::ResourceController.send :helper, MultiSite::SiteChooserHelper
    Admin::PagesController.send :helper, MultiSite::SiteChooserHelper
    admin.layouts.index.add(:top, "site_chooser")
    admin.pages.index.add(:top, "admin/layouts/site_chooser")
    admin.snippets.index.add(:top, "admin/layouts/site_chooser")


    unless defined? admin.site
      TrustyCms::AdminUI.send :include, MultiSite::AdminUI
      admin.site = TrustyCms::AdminUI.load_default_site_regions
    end
    
    if respond_to?(:tab)
      tab("Settings") do
        add_item "Sites", "/admin/sites", :after => "Extensions", :visibility => [:admin]
      end
    else
      admin.tabs.add "Sites", "/admin/sites", :visibility => [:admin]
    end
  end

  def deactivate
  end
end

class ActiveRecord::SiteNotFound < Exception; end
