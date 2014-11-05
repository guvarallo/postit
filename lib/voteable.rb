module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def vote_total
    vote_up - vote_down
  end

  def vote_up
    self.votes.where(vote: true).size
  end

  def vote_down
    self.votes.where(vote: false).size
  end
end