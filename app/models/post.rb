# Composed of attributes :id, :user_id (FK), :title and :body
class Post < ActiveRecord::Base
  attr_accessor :is_copy
  belongs_to :user

  validates :user, :body, :title, presence: true

  after_create :enrich_body, unless: :is_copy

  def copy
    Post.new(is_copy: true) do |post|
      sleep 1
      post.user = self.user
      post.body = self.body
      post.title = self.title
      post.save!
    end
  end

  def xcopy
    Post.skip_callback(:create, :after, :enrich_body)
    Post.new(is_copy: true) do |post|
      sleep 1
      post.user = self.user
      post.body = self.body
      post.title = self.title
      post.save!
    end
  ensure
    Post.set_callback(:create, :after, :enrich_body)
  end

  private

  def enrich_body
    self.body += "\nAuthored by #{user.name}"
  end
end
