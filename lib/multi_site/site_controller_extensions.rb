module MultiSite::SiteControllerExtensions
  def self.included(base)
    base.class_eval do
      before_filter :set_site
      alias_method_chain :process_page, :home_path
    end
  end

  # If it's a file not found page and the path doesn't include
  # the site's homepage path, try redirecting to include it.
  def process_page_with_home_path(page)
    homepage = Page.current_site.homepage
    if page.is_a?(FileNotFoundPage) && !params[:url].include?(homepage.slug)
      # if we got the right 404 page, keep it!
      if page.site_id != Page.current_site.id
        false if redirect_to "/#{homepage.slug}/#{params[:url]}"
      else
        process_page_without_home_path(page)
      end
    else
      process_page_without_home_path(page)
    end

  end

  def set_site
    Page.current_site = Site.find_for_host(request.host)
    true
  end
end
