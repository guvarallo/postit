module Sluggable
  extend ActiveSupport::Concern
  
  included do
    before_save     :generate_slug
    class_attribute :slug_column
  end

  def generate_slug
    self.slug = self.send(self.class.slug_column.to_sym).parameterize
    cl = self.class.find_by(slug: self.slug)
    count = 2
    while cl && cl != self
      self.slug = append_suffix(self.slug, count)
      cl = self.class.find_by(slug: self.slug)
      count += 1
    end
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

end