# Unlike other scoped classes, there is no site association in the Page class. Instead, Site has a homepage association and Page has some retrieval methods that turn a page request into site information.

module MultiSite::PageExtensions
  def self.included(base)
    base.class_eval {
      include InstanceMethods
      alias_method_chain :url, :sites
      mattr_accessor :current_site
      belongs_to :site
      before_create :associate_with_site
    }
    base.extend ClassMethods
    class << base

      def find_by_path(path, live=true)
        root = homepage
        raise Page::MissingRootPageError unless root
        path = root.path if clean_path(path) == "/"
        binding.pry
        result = root.find_by_path(path, live)

        # If it's a file not found page, see try adding the site homepage's
        # slug to the path and see if there's
        if result.is_a?(FileNotFoundPage)
          result = root.find_by_path("#{root.slug}/#{path}", live)
        end

        # If the result is still a FileNotFoundPage and it
        # doesn't match the current site, try to find one that does.
        if result.is_a?(FileNotFoundPage) && result.site_id != homepage.site_id
          get_site_specific_file_not_found(result)
        else
          result
        end

      end
      def current_site
        @current_site ||= Site.default
      end
      def current_site=(site)
        @current_site = site
      end
      def clean_path(path)
        "/#{ path.to_s.strip }/".gsub(%r{//+}, '/')
      end

      # if the result is a FileNotFoundPage, try to find the one for this site.
      # if you can't, return the initial result
      def get_site_specific_file_not_found(result)
        site_file_not_founds = FileNotFoundPage.where(site_id: homepage.site_id)
        site_file_not_founds.any? ? site_file_not_founds.first : result
      end

    end
  end

  module InstanceMethods
    def associate_with_site
      self.site_id = self.parent.site.id if self.site_id.nil?
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