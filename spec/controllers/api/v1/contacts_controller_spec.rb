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
  describe 'POST' do
    it 'adds a user to the database' do
      initial_count = Contact.count
      contact = build(:contact)
      post :create, params: {
        contact: {
          first_name: contact.first_name,
          last_name: contact.last_name,
          email: contact.email,
          phone_number: contact.phone_number,
        }
      }
      final_count = Contact.count
      expect(final_count).to eq(initial_count + 1)
    end
    it 'returns http success response' do
      contact = build(:contact)
      post :create, params: {
        contact: {
          first_name: contact.first_name,
          last_name: contact.last_name,
          email: contact.email,
          phone_number: contact.phone_number,
        }
      }
      expect(response.status).to eq 204
    end
  end
  describe 'DELETE' do
    before(:each) do
      5.times { create(:other_contact) }
      contact = Contact.last
      delete :destroy, params: { id: contact.id }
    end
    it 'removes a contact from the db' do
      expect(Contact.count).to eq 4
    end

    it 'returns a status ok' do
      expect(response.status).to eq 204
    end
  end
  describe 'UPDATE' do
    before(:each) do
      @contact = create(:contact)
      patch :update, params: {
        id: @contact.id,
        contact: {
          first_name: 'Bobby',
          last_name: 'Bobson',
          email: 'a@a.a',
          phone_number: 'xyz'
        }
      }
    end
    it 'updates the instance' do
      get :show, params: { id: @contact.id }
      json = JSON.parse(response.body)
      expect(json['first_name']).to eq 'Bobby'
      expect(json['last_name']).to eq 'Bobson'
      expect(json['email']).to eq 'a@a.a'
      expect(json['phone_number']).to eq 'xyz'
    end
    it 'returns a success status' do
      expect(response.status).to eq 204
    end
  end
end
