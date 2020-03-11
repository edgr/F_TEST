require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'Contact Data Presence' do
    before(:each) do
      @contact = create(:contact)
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
  describe 'Email uniqueness' do
    it 'is not valid if email already exists' do
      contact = create(:contact)
      contact2 = build(:contact)
      expect(contact2).to_not be_valid
    end
  end
end
