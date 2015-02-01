require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(first_name: "Test", last_name: "User", email: "test@user.com", password: "asd123", password_confirmation: "asd123")
	end

	test "should be valid" do
		assert @user.valid?
	end
	
	test "first name required" do
		@user.first_name = ""
		assert_not @user.valid?
	end
	
	test "last name required" do
		@user.last_name = ""
		assert_not @user.valid?
	end
	
	test "Passwords should be 6 characters minimum" do
		@user.password = "asd"
		@user.password_confirmation = "asd"
		assert_not @user.valid?
	end
	
	test "User first name can not be longer than 50 characters" do
		@user.first_name = "a"*51
		assert_not @user.valid?
	end
	
	test "User last name can not be longer than 50 characters" do
		@user.last_name = "a"*51
		assert_not @user.valid?
	end
	
	test "User email should be valid format" do
		valid_emails = %w[test@user.com Test@UsER.cOM U_S-e.r@test.user.se test.user@test.user.co.uk]
		valid_emails.each do |e|
			@user.email = e
			assert @user.valid?, "#{e.inspect} should be valid"
		end
	end
	
	test "Should not validate invalid email" do
		valid_emails = %w[testuser.com Test@UsER @test.user.se .@test.user...co.uk]
		valid_emails.each do |e|
			@user.email = e
			assert_not @user.valid?, "#{e.inspect} should be invalid"
		end
	end
	
	test "Email should be lower case" do
		e = "Test@UsEr.CoM"
		@user.email = e
		@user.save
		assert_equal e.downcase, @user.reload.email
	end
	
	test "Email should be unique" do
		u2 = @user.dup
		u2.email = @user.email.upcase
		@user.save
		assert_not u2.valid?
	end
end
