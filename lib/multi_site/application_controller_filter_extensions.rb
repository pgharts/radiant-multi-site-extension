module MultiSite::ApplicationControllerFilterExtensions

  def self.included(base)
    base.class_eval {
      prepend_before_filter :set_site
      alias_method_chain :authenticate, :site
    }
  end

protected

  def authenticate_with_site
    self.current_site = discover_current_site
    authenticate_without_site
  end

  def set_site
    true if self.current_site = discover_current_site
  end

end