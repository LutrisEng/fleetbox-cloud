require "test_helper"

class LineItemTypesTest < ActiveSupport::TestCase
  test "all methods run without raising" do
    lit = LineItemTypes::GLOBAL
    lit.file_name
    lit.file_contents
    lit.components
    lit.components_by_id
    lit.top_level_categories
    lit.all_categories
    lit.all_categories_by_id
    lit.all_types
    lit.all_types_by_id
  end

  test "all types appear in all_types_by_id" do
    lit = LineItemTypes::GLOBAL
    lit.all_types.each do |type|
      assert_not_nil(lit.all_types_by_id[type.id])
      assert_not_nil(lit.get_type(type.id))
    end
  end

  test "all categories appear in all_types_by_id" do
    lit = LineItemTypes::GLOBAL
    lit.all_categories.each do |category|
      assert_not_nil(lit.all_categories_by_id[category.id])
      assert_not_nil(lit.get_category(category.id))
    end
  end
end
