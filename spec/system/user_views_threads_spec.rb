require 'rails_helper'

RSpec.describe "Creating and viewing topics", type: :system do
  let(:poster) { create(:user, email: 'poster@example.com', password: 'password1234') }
  let(:viewer) { create(:user, email: 'viewer@example.com', password: 'password1234') }
  
  before do
    driven_by(:rack_test)

    sign_in poster
  end

  it "should allow logged in user to create a new topic and view it" do
    visit '/'

    expect(page).to have_content ''

    click_on 'new topic'

    fill_in 'title', with: 'post your dogs'
    fill_in 'body', with: "here is a text description of Pig since images aren't supported"
    click_on 'post'

    expect(page).to have_content 'post your dogs'
    click_on 'see all topics'

    expect(page).to have_content 'all topics'
    expect(page).to have_content 'post your dogs'

    logout
    sign_in viewer

    visit '/'

    click_on 'post your dogs'
    expect(page).to have_content 'post your dogs'

    fill_in 'body', with: 'thanks I appreciate it'
    click_on 'reply'

    click_on 'see all topics'

    expect(page).to have_content(2)
  end
end
