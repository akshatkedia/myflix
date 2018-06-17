require 'rails_helper'

RSpec.feature "UserFollowsAnotherUsers", type: :feature do
  scenario "user follows another user" do
    alice = Fabricate(:user)
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', category: comedy)
    Fabricate(:review, video: monk, user: alice)

    sign_in
    click_on_video_on_home_page monk

    click_link alice.full_name
    click_link 'Follow'
    expect(page).to have_content(alice.full_name)

    unfollow(alice)
    expect(page).to_not have_content(alice.full_name)
  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end
