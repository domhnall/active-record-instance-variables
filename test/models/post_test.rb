require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(name: "Domhnall")
    @attrs = {
      user: @user,
      title: "AR instance variables",
      body: "Who'd have thunk it."
    }
    @post = Post.new(@attrs)
  end

  test "should be valid with required params" do
    assert @post.valid?
  end

  test "should be invalid when user_id is not set" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "should be invalid when title is empty" do
    @post.title = ""
    assert_not @post.valid?
  end

  test "should be invalid when body is empty" do
    @post.body = ""
    assert_not @post.valid?
  end

  test "should enrich body with post author when saving" do
    assert_equal @post.body, "Who'd have thunk it."
    @post.save
    assert_equal @post.body, "Who'd have thunk it.\nAuthored by Domhnall"
  end

  test "copy should return a new Post object" do
    assert @post.copy.is_a?(Post)
    assert_not_equal @post.copy.id, @post.id
  end

  test "copy should set post body to be equal to the original" do
    assert_equal @post.copy.body, @post.body
  end

  test "copy should be thread-safe" do
    n=10
    (0...n).map do |i|
      Thread.new do
        puts "Thread #{i}"
        post = Post.new({
          user: @user,
          title: "AR instance variables #{i}",
          body: "Who'd have thunk it #{i}."
        })
        copy = post.copy
        puts copy.body
        assert_equal post.body, copy.body
      end
    end.each(&:join)
  end
end
