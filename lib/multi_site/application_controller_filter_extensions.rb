module MultiSite::ApplicationControllerFilterExtensions

  def self.included(base)
    base.class_eval {
      prepend_before_filter :set_site
    }
  end

protected

  def set_site
    Rails.logger.error("IN THE EVAL ROOM")
    true if self.current_site = discover_current_site
  end

end