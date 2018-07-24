require "application_system_test_case"

class RestaurantsTest < ApplicationSystemTestCase
  setup do
    @restaurant = restaurants(:one)
  end

  test "visiting the index" do
    visit restaurants_url
    assert_selector "h1", text: "Restaurants"
  end

  test "creating a Restaurant" do
    visit restaurants_url
    click_on "New Restaurant"

    fill_in "Address", with: @restaurant.address
    fill_in "Categories", with: @restaurant.categories
    fill_in "Hour Close", with: @restaurant.hour_close
    fill_in "Hour Open", with: @restaurant.hour_open
    fill_in "Image Url", with: @restaurant.image_url
    fill_in "Lat", with: @restaurant.lat
    fill_in "Location", with: @restaurant.location
    fill_in "Long", with: @restaurant.long
    fill_in "Name", with: @restaurant.name
    fill_in "Open Days", with: @restaurant.open_days
    fill_in "Phone", with: @restaurant.phone
    fill_in "Price", with: @restaurant.price
    fill_in "Rating", with: @restaurant.rating
    fill_in "Url Restaurant", with: @restaurant.url_restaurant
    fill_in "Yelp", with: @restaurant.yelp_id
    click_on "Create Restaurant"

    assert_text "Restaurant was successfully created"
    click_on "Back"
  end

  test "updating a Restaurant" do
    visit restaurants_url
    click_on "Edit", match: :first

    fill_in "Address", with: @restaurant.address
    fill_in "Categories", with: @restaurant.categories
    fill_in "Hour Close", with: @restaurant.hour_close
    fill_in "Hour Open", with: @restaurant.hour_open
    fill_in "Image Url", with: @restaurant.image_url
    fill_in "Lat", with: @restaurant.lat
    fill_in "Location", with: @restaurant.location
    fill_in "Long", with: @restaurant.long
    fill_in "Name", with: @restaurant.name
    fill_in "Open Days", with: @restaurant.open_days
    fill_in "Phone", with: @restaurant.phone
    fill_in "Price", with: @restaurant.price
    fill_in "Rating", with: @restaurant.rating
    fill_in "Url Restaurant", with: @restaurant.url_restaurant
    fill_in "Yelp", with: @restaurant.yelp_id
    click_on "Update Restaurant"

    assert_text "Restaurant was successfully updated"
    click_on "Back"
  end

  test "destroying a Restaurant" do
    visit restaurants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Restaurant was successfully destroyed"
  end
end
