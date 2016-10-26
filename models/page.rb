class Page < Airmodel::Model

  # find this page in Airtable
  def self.find_by_slug(slug)
    slug = slug.downcase
    page = self.find_by("slug" => slug)
    if page
      page["slides"] = page.ordered_slides
      page
    else
      nil
    end
  end

  # search for this page in memcached, or
  # pull it from airtable if it's not cached
  def self.find_by_slug_cached(slug)
    slug = slug.downcase
    App.cache.fetch("pages_#{slug}") {
      self.find_by_slug(slug)
    }
  end

  def ordered_slides
    Slide.find(self.slides.reverse)
  end

  # override cache key to work by slug
  # instead of ID
  def cache_key
    "pages_#{self.slug}"
  end

end
