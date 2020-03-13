require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  describe 'GET all contacts' do
    it 'returns http success response' do
      get :index
      expect(response.status).to eq 200
    end
    it 'returns a JSON response with required attributes' do
      5.times { create(:other_contact) }
      get :index
      expect(response).to match_response_schema('contacts')
    end
    it 'returns all contacts in the database' do
      5.times { create(:other_contact) }
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(5)
    end
  end
  describe 'GET one contact' do
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
  describe 'POST new contact' do
    describe 'contact is created' do
      it 'adds a contact to the database' do
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
      it 'returns http created response' do
        contact = build(:contact)
        post :create, params: {
          contact: {
            first_name: contact.first_name,
            last_name: contact.last_name,
            email: contact.email,
            phone_number: contact.phone_number,
          }
        }
        expect(response.status).to eq 201
      end
    end
    describe 'creation fails if email already exists' do
      it 'does not add a contact to the database' do
        contact = create(:contact)
        initial_count = Contact.count
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'john.doe@gmail.com',
            phone_number: '123456789',
          }
        }
        final_count = Contact.count
        expect(final_count).to eq(initial_count)
      end
      it 'returns http failure response' do
        contact = create(:contact)
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'john.doe@gmail.com',
            phone_number: '123456789'
          }
        }
        expect(response.status).to eq 422
      end
    end
    describe 'creation fails if a field is empty' do
      it 'does not add a contact to the database' do
        contact = create(:contact)
        initial_count = Contact.count
        post :create, params: {
          contact: {
            first_name: '',
            last_name: 'Bobson',
            email: 'john.doe@gmail.com',
            phone_number: '123456789'
          }
        }
        final_count = Contact.count
        expect(final_count).to eq(initial_count)
      end
      it 'returns http failure response' do
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: '',
            email: 'john.doe@gmail.com',
            phone_number: '123456789'
          }
        }
        expect(response.status).to eq 422
      end
    end
    describe 'creation fails if email has wrong format' do
      it 'does not add a contact in the database' do
        contact = create(:contact)
        initial_count = Contact.count
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'aaa',
            phone_number: '123456789'
          }
        }
        final_count = Contact.count
        expect(final_count).to eq(initial_count)
      end
      it 'returns http failure response' do
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'aaa',
            phone_number: '123456789'
          }
        }
        expect(response.status).to eq 422
      end
    end
  end
  describe 'DELETE contact' do
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
  describe 'UPDATE contact' do
    describe 'contact is updated' do
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
        expect(response.status).to eq 200
      end
    end
    describe 'update fails if email already exists' do
      it 'does not add change the email in the database' do
        contact = create(:contact)
        second_contact = create(:second_contact)
        patch :update, params: {
          id: second_contact.id,
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'john.doe@gmail.com',
            phone_number: '123456789',
          }
        }
        expect(second_contact.email).to eq('bobby.bobson@yahoo.com')
      end
      it 'returns http failure response' do
        contact = create(:contact)
        post :create, params: {
          contact: {
            first_name: 'Bob',
            last_name: 'Bobson',
            email: 'john.doe@gmail.com',
            phone_number: '123456789'
          }
        }
        expect(response.status).to eq 422
      end
    end
    describe 'update fails if a field is empty' do
      it 'does not add change the email in the database' do
        contact = create(:contact)
        patch :update, params: {
          id: contact.id,
          contact: {
            first_name: 'John',
            last_name: '',
            email: 'john.doe@gmail.com',
            phone_number: '123456789',
          }
        }
        expect(contact.last_name).to eq('Doe')
      end
      it 'returns http failure response' do
        contact = create(:contact)
        patch :update, params: {
          id: contact.id,
          contact: {
            first_name: 'John',
            last_name: '',
            email: 'john.doe@gmail.com',
            phone_number: '123456789',
          }
        }
        expect(response.status).to eq 422
      end
    end
    describe 'update fails if email has wrong format' do
      it 'does not add a contact in the database' do
        contact = create(:contact)
        patch :update, params: {
          id: contact.id,
          contact: {
            first_name: 'John',
            last_name: 'Doe',
            email: 'johngmail',
            phone_number: '123456789',
          }
        }
        expect(contact.email).to eq('john.doe@gmail.com')
      end
      it 'returns http failure response' do
        contact = create(:contact)
        patch :update, params: {
          id: contact.id,
          contact: {
            first_name: 'John',
            last_name: 'Doe',
            email: 'johngmail',
            phone_number: '123456789',
          }
        }
        expect(response.status).to eq 422
      end
    end
  end
end
