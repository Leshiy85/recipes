require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
	def setup
		@user = User.new(username: "John", email: "John@example.com")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	test "username should be present" do
		@user.username = " "
		assert_not @user.valid?
	end

	test "username should not too long" do
		@user.username = "a" * 15
		assert_not @user.valid?
	end

	test "username should be not too short" do
		@user.username = "aaa"
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "email should be not too long" do
		@user.email = "a" * 25 + "@example.com"
		assert_not @user.valid?
	end

	test "email should be not too short" do
		@user.email = "sssas"
		assert_not @user.valid?
	end

	test "email should be unique" do 
		assert User.create(@attrs)
    	assert user = User.new(@attrs)
    	assert user.invalid?
    	assert user.errors.include?(:email)
    end

    test "email validation should accept valid addresses" do
		valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.au laura+joe@monk.cm]
		valid_addresses.each do |valid|
			@user.email = valid
			assert @user.valid?, '#{valid.inspect} should be valid'
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
		invalid_addresses.each do |invalid|
			@user.email = invalid
			assert_not @user.valid?, '#{invalid.inspect} should be invalid'
		end
	end

end