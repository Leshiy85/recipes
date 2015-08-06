require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.create(username: "Leonardo", email: "Leonardo@example.com")
  	@recipe = @user.recipes.build(title: "peanuts", summary: "nyammy peanuts for all", description: "best peanuts and yes yes yes")
  end

  test "recipe should be valid" do
  	assert @recipe.valid?
  end

  test "user_id should be present" do
		@recipe.user_id = nil
		assert_not @recipe.valid?
	end

	test "title should be present" do
		@recipe.title = " "
		assert_not @recipe.valid?
	end

	test "title length should be not too long" do
		@recipe.title = "a" * 20
		assert_not @recipe.valid?
	end

	test "title length should be not too short" do
		@recipe.title = "aaaa"
		assert_not @recipe.valid?
	end

	test "summary should be present" do
		@recipe.summary = " "
		assert_not @recipe.valid?
	end

	test "summary length should be not too long" do
		@recipe.summary = "a" * 39
		assert_not @recipe.valid?
	end

	test "summary length should be not too short" do
		@recipe.summary = "a" * 10
		assert_not @recipe.valid?
	end

	test "description should be present" do
		@recipe.description = " "
		assert_not @recipe.valid?
	end

	test "description should be not too long" do
		@recipe.description = "a" * 101
		assert_not @recipe.valid?
	end

	test "description should be not too short" do
		@recipe.description = "aaaa"
		assert_not @recipe.valid?
	end


end
