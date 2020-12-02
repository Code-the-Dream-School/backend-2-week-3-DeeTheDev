require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  describe "get customers_path" do
    it "renders the index view" do
      get customers_path
      expect(response.status).to eq(200)
    end
  end
  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
    it "redirects to the index path if the customer id is invalid" do
      get customer_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_path" do
    it "renders the :new template" do
      customer = FactoryBot.create(:customer)
      get new_customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
  end
  describe "get edit_customer_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
  end
  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end
  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to_not change(Customer, :count)
      expect(response.status).to eq(200)
    end
  end
  describe "put customer_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      put 'http://localhost/customers/update', params:  {"customer": {id: 1, customer: customer_attributes} }
      # headers: authorized_user_headers
      expect(response).to render_template(:show)
    end
  end
  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { put 'http://localhost:3000/customers/:id', params: {customer: customer_attributes}
      }.to_not change(Customer, :count)
      expect(response.status).to eq(302)
    end
  end
  describe "delete a customer record" do
    it "deletes a customer record" do
      expect { delete :destroy, id: 1 }.to change(Customer, :count)
      # expect { delete :destroy, params: {customer: customer_attributes}
      # }.to change(Customer, :count)
      expect(response.status).to eq(202)
    end
  end
end
