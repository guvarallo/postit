class Post < ActiveRecord::Base
	belongs_to  :creator, foreign_key: 'user_id', class_name: 'User'
	has_many    :comments
	has_many    :post_categories
	has_many    :categories, through: :post_categories
  has_many    :votes, as: :voteable

  before_save :generate_slug

  validates   :title, presence: true, length: {minimum: 5}
  validates   :url, presence: true, uniqueness: true
  validates   :description, presence: true

  def vote_total
    vote_up - vote_down
  end

  def vote_up
    self.votes.where(vote: true).size
  end

  def vote_down
    self.votes.where(vote: false).size
  end

  def generate_slug
    self.slug = self.title.parameterize
    post = Post.find_by(slug: self.slug)
    count = 2
    while post && post != self
      self.slug = append_suffix(self.slug, count)
      post = Post.find_by(slug: self.slug)
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