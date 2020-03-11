require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'Contact Data Presence' do
    before(:each) do
      @contact = Contact.new(
        first_name: 'John',
        last_name: 'Bobson',
        email: 'a@a.a',
        phone_number: '123456789'
      )
    end
    it 'is not valid without a first_name' do
      @contact.first_name = nil
      expect(@contact).to_not be_valid
    end
    it 'is not valid without a last_name' do
      @contact.last_name = nil
      expect(@contact).to_not be_valid
    end
    it 'is not valid without an email' do
      @contact.email = nil
      expect(@contact).to_not be_valid
    end
    it 'is not valid without a phone_number' do
      @contact.phone_number = nil
      expect(@contact).to_not be_valid
    end
  end
end
