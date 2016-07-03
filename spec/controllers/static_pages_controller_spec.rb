require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #contact' do
    it 'renders the contact page' do
      get :contact

      expect(response).to render_template 'contact'
    end
  end

  describe 'GET #about' do
    it 'renders the contact page' do
      get :about

      expect(response).to render_template 'about'
    end
  end
end
