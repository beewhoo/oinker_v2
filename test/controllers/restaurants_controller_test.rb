require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, categories: @restaurant.categories, hour_close: @restaurant.hour_close, hour_open: @restaurant.hour_open, image_url: @restaurant.image_url, lat: @restaurant.lat, location: @restaurant.location, long: @restaurant.long, name: @restaurant.name, open_days: @restaurant.open_days, phone: @restaurant.phone, price: @restaurant.price, rating: @restaurant.rating, url_restaurant: @restaurant.url_restaurant, yelp_id: @restaurant.yelp_id } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, categories: @restaurant.categories, hour_close: @restaurant.hour_close, hour_open: @restaurant.hour_open, image_url: @restaurant.image_url, lat: @restaurant.lat, location: @restaurant.location, long: @restaurant.long, name: @restaurant.name, open_days: @restaurant.open_days, phone: @restaurant.phone, price: @restaurant.price, rating: @restaurant.rating, url_restaurant: @restaurant.url_restaurant, yelp_id: @restaurant.yelp_id } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end
end
