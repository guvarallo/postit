class Category < ActiveRecord::Base
  include Slugreate

	has_many :post_categories
	has_many :posts, through: :post_categories

  validates :name, presence: true

  slugable_column :name
  
end