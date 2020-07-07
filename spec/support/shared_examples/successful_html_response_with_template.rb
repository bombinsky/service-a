# frozen_string_literal: true

shared_examples 'successful html response with template' do |template_name|
  it 'responds with ok' do
    expect(response.status).to eq(200)
  end

  it 'responds with content type text/html; charset=utf-8' do
    expect(response.content_type).to eq 'text/html; charset=utf-8'
  end

  it "renders #{template_name} template" do
    expect(response).to render_template(template_name)
  end
end
