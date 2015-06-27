module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def generate_slug!
    a_slug = self[slug_column].parameterize

    return if self.slug && self.slug[/\w+/]== a_slug
    slug_copies = self.class.where("slug LIKE :prefix",prefix: "#{a_slug}%").size
    if slug_copies.zero? || slug_copies == 1 && self.slug
      self.slug = a_slug
    else
      self.slug = "#{a_slug}-#{slug_copies + 1}"
    end
  end

  def to_param
    slug
  end

  module ClassMethods
    def sluggable_column(column_name)
      self.slug_column = column_name
    end
  end
end
