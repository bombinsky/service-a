# frozen_string_literal: true

describe 'User visits root path' do
  it 'not being authenticated' do
    visit root_path

    expect(page).to have_link 'Twitter'
  end

  it 'being authenticated' do
    login_with_oauth

    visit root_path

    expect(page).to have_link 'Start now'
  end
end
