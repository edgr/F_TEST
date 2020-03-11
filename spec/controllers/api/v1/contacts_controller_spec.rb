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
  describe 'GET show' do
    it 'returns http success response' do
      contact = create(:contact)
      get :show, params: { id: contact.id }
      expect(response.status).to eq 200
    end
    it 'returns the right contact details' do
      contact = create(:contact)
      get :show, params: { id: contact.id }
      json = JSON.parse(response.body)
      expect(json['first_name']).to eq('John')
      expect(json['last_name']).to eq('Doe')
      expect(json['email']).to eq('john.doe@gmail.com')
      expect(json['phone_number']).to eq('123456789')
    end
  end
  describe 'POST create' do
    before(:each) do
      contact = build(:contact)
      contact_params = {
        contact: {
          first_name: contact.first_name,
          last_name: contact.last_name,
          email: contact.email,
          phone_number: contact.phone_number
        }
      }
      post :create, params: { contact: contact_params }
    end
    it 'returns http success response' do
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
    end
    it 'adds a user to the database' do
      contact = Contact.all.size
      expect(contact).to eq(contact + 1)
    end
  end
end
