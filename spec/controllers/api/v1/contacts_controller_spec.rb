require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  describe 'GET index' do
    it 'returns http success response' do
      get :index
      expect(response.status).to eq 200
    end
    it 'JSON response get attributes required' do
      5.times { create(:other_contact) }
      get :index
      expect(response).to match_response_schema('contacts')
    end
    it 'returns all users in db' do
      5.times { create(:other_contact) }
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(5)
    end
  end
end
