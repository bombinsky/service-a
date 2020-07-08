# frozen_string_literal: true

feature 'User visits root path' do

  scenario 'not being authenticated' do
    visit root_path

    expect(page).to have_link 'Twitter'
  end


  scenario 'being authenticated' do
    login_with_oauth

    visit root_path

    expect(page).to have_link 'Start now'
  end
end