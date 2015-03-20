# Unlike other scoped classes, there is no site association in the Page class. Instead, Site has a homepage association and Page has some retrieval methods that turn a page request into site information.

module MultiSite::PageExtensions
  def self.included(base)
    base.class_eval {
      alias_method_chain :url, :sites
      mattr_accessor :current_site
      belongs_to :site
      before_create :associate_with_site
    }
    base.extend ClassMethods
    class << base

      def associate_with_site
        self.site_id = Page.current_site.site_id if self.site_id.nil?
      end

      def find_by_path(path, live=true)
        root = homepage
        raise Page::MissingRootPageError unless root
        root.find_by_path(path, live)
      end
      def current_site
        @current_site ||= Site.default
      end
      def current_site=(site)
        @current_site = site
      end
    end
  end
  
  module ClassMethods

    def find_by_slug_for_site(slug)
      self.where(slug: slug, site_id: Page.current_site.id)
    end

    def homepage
      if current_site.is_a?(Site)
        homepage = self.current_site.homepage
      end
      homepage ||= find_by_parent_id(nil)
    end
  end
  
  def url_with_sites
    if parent
      parent.child_url(self)
    else
      "/"
    end
  end
  
end