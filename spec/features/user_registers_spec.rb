require 'rails_helper'

RSpec.feature "UserRegisters", { type: :feature, vcr: true, js: true } do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_info
    fill_in_card("4242424242424242")
    click_button "Sign Up"
    expect(page).to have_content("Thank you for registering with MyFlix. Please sign in now.")
  end

  scenario "with valid user info and invalid card" do
    fill_in_valid_user_info
    fill_in_card("123")
    click_button "Sign Up"
    expect(page).to have_content("The card number is not a valid credit card number.")
  end

  scenario "with valid user info and declined card" do
    fill_in_valid_user_info
    fill_in_card("4000000000000002")
    click_button "Sign Up"
    expect(page).to have_content("Your card was declined.")
  end

  scenario "with invalid user info and valid card" do
    fill_in_invalid_user_info
    fill_in_card("4242424242424242")
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please check errors below.")
  end

  scenario "with invalid user info and invalid card" do
    fill_in_invalid_user_info
    fill_in_card("123")
    click_button "Sign Up"
    expect(page).to have_content("The card number is not a valid credit card number.")
  end

  scenario "with invalid user info and declined card" do
    fill_in_invalid_user_info
    fill_in_card("4000000000000002")
    click_button "Sign Up"
    expect(page).to have_content("Invalid user information. Please check errors below.")
  end

  def fill_in_valid_user_info
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_invalid_user_info
    fill_in "Email Address", with: "john@example.com"
  end

  def fill_in_card(card_number)
    fill_in "Credit Card Number", with: card_number
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2022", from: "date_year"
  end
end
