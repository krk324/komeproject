require 'rails_helper'

feature "User press order button" do

  scenario 'successfully' do
    visit root_path
    sing_in_as('teru@example.com')
    click_button '+'
    click_link 'Add Memo'

    fill_in 'Memo', with: 'Hello'
    click_button 'Create Memo'


    expect(page).to have_content 'Hello'


    # Keep in mind making the test too specefic will break the rspec when
    # chaging your css style.
  end

  # scenario 'unsuccessfully due to required fields being blank' do

  # end
end
