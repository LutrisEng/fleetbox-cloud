require "application_system_test_case"

class TireSetsTest < ApplicationSystemTestCase
  setup do
    @tire_set = tire_sets(:pipers_summer_tires)
  end

  test "visiting the index" do
    visit tire_sets_url
    assert_selector "h1", text: "Tire sets"
  end

  test "should create tire set" do
    visit tire_sets_url
    click_on "New tire set"

    fill_in "Aspect ratio", with: @tire_set.aspect_ratio
    fill_in "Base miles", with: @tire_set.base_miles
    fill_in "Breakin", with: @tire_set.breakin
    fill_in "Construction", with: @tire_set.construction
    fill_in "Diameter", with: @tire_set.diameter
    check "Hidden" if @tire_set.hidden
    fill_in "Load index", with: @tire_set.load_index
    fill_in "Make", with: @tire_set.make
    fill_in "Model", with: @tire_set.model
    fill_in "Speed rating", with: @tire_set.speed_rating
    fill_in "Tin", with: @tire_set.tin
    fill_in "User display name", with: @tire_set.user_display_name
    fill_in "Vehicle type", with: @tire_set.vehicle_type
    fill_in "Width", with: @tire_set.width
    click_on "Create Tire set"

    assert_text "Tire set was successfully created"
    click_on "Back"
  end

  test "should update Tire set" do
    visit tire_set_url(@tire_set)
    click_on "Edit this tire set", match: :first

    fill_in "Aspect ratio", with: @tire_set.aspect_ratio
    fill_in "Base miles", with: @tire_set.base_miles
    fill_in "Breakin", with: @tire_set.breakin
    fill_in "Construction", with: @tire_set.construction
    fill_in "Diameter", with: @tire_set.diameter
    check "Hidden" if @tire_set.hidden
    fill_in "Load index", with: @tire_set.load_index
    fill_in "Make", with: @tire_set.make
    fill_in "Model", with: @tire_set.model
    fill_in "Speed rating", with: @tire_set.speed_rating
    fill_in "Tin", with: @tire_set.tin
    fill_in "User display name", with: @tire_set.user_display_name
    fill_in "Vehicle type", with: @tire_set.vehicle_type
    fill_in "Width", with: @tire_set.width
    click_on "Update Tire set"

    assert_text "Tire set was successfully updated"
    click_on "Back"
  end

  test "should destroy Tire set" do
    @tire_set = TireSet.create

    visit tire_set_url(@tire_set)
    click_on "Destroy this tire set", match: :first

    assert_text "Tire set was successfully destroyed"
  end
end
