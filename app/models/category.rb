class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, through: :post_categories

  validates :name, presence: true

  before_save :generate_slug

  def generate_slug
    self.slug = self.name.parameterize
    cat = Category.find_by(slug: self.slug)
    count = 2
    while cat && cat != self
      self.slug = append_suffix(self.slug, count)
      cat = Category.find_by(slug: self.slug)
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
  
end