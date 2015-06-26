module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
  end

  def generate_slug!
    a_slug = self.read_attribute(self.attribute_names[1]).parameterize
    return slug if slug != nil && slug[0..-3] == a_slug
    slug_copies = self.class.where("slug LIKE :prefix",prefix: "#{a_slug}%").size
    self.slug = slug_copies.zero? ? a_slug : "#{a_slug}-#{slug_copies + 1}"
  end

  def to_param
    slug
  end
end
