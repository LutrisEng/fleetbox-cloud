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

  test "can generate all fields without raising" do
    lit = LineItemTypes::GLOBAL
    lit.all_types.each do |type|
      type.fields
    end
  end

  test "all types appear in all_types_by_id" do
    lit = LineItemTypes::GLOBAL
    lit.all_types.each do |type|
      assert_not_nil(lit.all_types_by_id[type.id])
      assert_not_nil(lit.get_type(type.id))
    end
  end

  test "all categories appear in all_categories_by_id" do
    lit = LineItemTypes::GLOBAL
    lit.all_categories.each do |category|
      assert_not_nil(lit.all_categories_by_id[category.id])
      assert_not_nil(lit.get_category(category.id))
    end
  end

  test "all components appear in components_by_id" do
    lit = LineItemTypes::GLOBAL
    lit.components.each do |component|
      assert_not_nil(lit.components_by_id[component.id])
      assert_not_nil(lit.get_component(component.id))
    end
  end

  test "all subcategories are accounted for" do
    def check_category(category)
      assert_equal(category, LineItemTypes::GLOBAL.get_category(category.id))
      category.subcategories.each do |subcategory|
        check_category(subcategory)
      end
    end
    LineItemTypes::GLOBAL.top_level_categories.each do |category|
      check_category(category)
    end
  end

  test "all types are accounted for" do
    def check_category(category)
      category.types.each do |type|
        assert_equal(type, LineItemTypes::GLOBAL.get_type(type.id))
      end
      category.subcategories.each do |subcategory|
        check_category(subcategory)
      end
    end
    LineItemTypes::GLOBAL.top_level_categories.each do |category|
      check_category(category)
    end
  end

  test "category display name translations work" do
    I18n.with_locale(:en) do
      assert_equal("Window modifications", LineItemTypes::GLOBAL.get_category("windowMods").display_name)
    end
  end

  test "type description translations work" do
    I18n.with_locale(:en) do
      assert_equal("Engine oil was drained and refilled.", LineItemTypes::GLOBAL.get_type("engineOilChange").description)
      assert_nil(LineItemTypes::GLOBAL.get_type("cabinAirFilterChange").description, "LineItemTypes::Type#description returns non-nil for missing description")
    end
  end

  test "english translations exist for every category" do
    I18n.with_locale(:en) do
      LineItemTypes::GLOBAL.all_categories.each do |category|
        assert(I18n.exists?(category.display_name_key), "No translation for category #{category.id} (parent #{category.parent&.id})")
      end
    end
  end

  test "english translations exist for every type" do
    I18n.with_locale(:en) do
      LineItemTypes::GLOBAL.all_types.each do |type|
        assert(I18n.exists?(type.display_name_key), "No translation for type #{type.id} (category #{type.category&.id})")
      end
    end
  end

  test "english translations exist for every type field short name" do
    I18n.with_locale(:en) do
      LineItemTypes::GLOBAL.all_types.each do |type|
        type.fields.each do |field|
          assert(I18n.exists?(field.short_display_name_key), "No translation for type #{type.id} field #{field.id} (category #{type.category&.id})")
        end
      end
    end
  end
end
