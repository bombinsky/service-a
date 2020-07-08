# frozen_string_literal: true

describe 'User creates external urls request' do
  it 'not being authenticated' do
    visit new_external_urls_request_path

    expect(page).to have_link 'Twitter'
  end

  it 'being authenticated but providing invalid params' do
    login_with_oauth
    visit new_external_urls_request_path
    fill_in 'external_urls_request_email', with: 'bombinsky'
    click_on('Create request')

    expect(page).to have_selector(id: 'external_urls_request_email', class: 'form-control is-invalid')
    expect(page).to have_button 'Create request'
  end

  it 'being authenticated creates a request then gets back to homepage' do
    allow_service_call(Publish, with: ['external_urls_requests', kind_of(String)])

    login_with_oauth
    visit new_external_urls_request_path
    fill_in 'external_urls_request_email', with: 'bombinsky@gmail.com'
    click_on('Create request')

    expect(page).to have_text 'Following request of urls to external resources has been created'

    click_on('Back to homepage')

    expect(page).to have_link 'Start now'
  end
end
