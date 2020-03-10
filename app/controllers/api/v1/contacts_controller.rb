class Api::V1::ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    render json: @contacts, only: %i[id first_name last_name email]
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact, only: %i[id first_name last_name email phone_number]
  end

  def create
    @contact = Contact.create(contact_params)
    render json: @contact, only: %i[id first_name last_name email phone_number]
  end

  def destroy
    Contact.destroy(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(contact_params)
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
  end
end
