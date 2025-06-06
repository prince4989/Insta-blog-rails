require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Technology")
  end

  test "should be valid with a proper name" do
    assert @category.valid?
  end

  test "should be invalid without a name" do
    @category.name = ""
    assert_not @category.valid?
    assert_includes @category.errors[:name], "can't be blank"
  end

  test "should be invalid if name is too short" do
    @category.name = "Te"
    assert_not @category.valid?
    assert_includes @category.errors[:name], "is too short (minimum is 3 characters)"
  end

  test "should be invalid if name is too long" do
    @category.name = "T" * 26
    assert_not @category.valid?
    assert_includes @category.errors[:name], "is too long (maximum is 25 characters)"
  end

  test "should be invalid if name is not unique" do
    duplicate_category = @category.dup
    @category.save
    assert_not duplicate_category.valid?
    assert_includes duplicate_category.errors[:name], "has already been taken"
  end
end
