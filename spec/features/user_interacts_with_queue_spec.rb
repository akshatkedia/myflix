require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and redorders videos in the queue' do
    comedy = Fabricate(:category)
    monk = Fabricate(:video, title: 'Monk', category: comedy)
    south_park = Fabricate(:video, title: 'South Park', category: comedy)
    futurama = Fabricate(:video, title: 'Futurama', category: comedy)

    sign_in

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen('+ My Queue')

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)

    set_video_position(monk, 3)
    set_video_position(south_park, 1)
    set_video_position(futurama, 2)
    update_queue

    # find("input[data-video-id='#{monk.id}']").set(3)
    # find("input[data-video-id='#{south_park.id}']").set(1)
    # find("input[data-video-id='#{futurama.id}']").set(2)

    # double slash ( // ) means you are starting anywhere in the html document
    # dot ( . ) means the current level
    # second double slash ( // ) means anywhere under the <tr>
    # when you query attributes you use the @ symbol

    expect_video_postion(south_park, 1)
    expect_video_postion(futurama, 2)
    expect_video_postion(monk, 3)
  end

  def expect_video_to_be_in_queue(video)
    expect(page).to have_content video.title
  end

  def expect_link_not_to_be_seen(link_text)
    expect(page).to_not have_content link_text
  end

  def add_video_to_queue(video)
    visit home_path
    click_on_video_on_home_page video
    click_link '+ My Queue'
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def update_queue
    click_button 'Update Instant Queue'
  end

  def expect_video_postion(video, position)
    expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end
