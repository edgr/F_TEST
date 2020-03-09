class api::v1::ContactsController < ApplicationController
  def index
    render json: Contact.All
  end
end
