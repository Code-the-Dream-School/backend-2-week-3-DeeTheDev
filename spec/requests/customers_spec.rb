require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do
  #GET SHOW REQUEST
  describe "get customers_path" do
    it "renders the index view" do
      get customers_path
      expect(response.status).to eq(200)
    end
  end

  #GET CUSTOMER (ID)
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

  #GET NEW REQUEST
  describe "get new_customer_path" do
    it "renders the :new template" do
      customer = FactoryBot.create(:customer)
      get new_customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
  end

  #GET EDIT REQUEST
  describe "get edit_customer_path" do
    it "renders the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response.status).to eq(200)
    end
  end

  #POST REQUEST VALID DATA
  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end

  #POST REQUEST INVALID DATA
  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: {customer: customer_attributes}
    }.to_not change(Customer, :count)
      expect(response.status).to eq(200)
    end
  end

  #PUT REQUEST VALID DATA
  describe "put customer_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      customer = FactoryBot.create(:customer)
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes[:first_name] = 'New Name'
      expect{ put customer_path( id: customer.id ), params:  { customer: customer_attributes }
      }.to change{ customer.reload.first_name }

      expect(response).to redirect_to(customer_path( id: customer.id ))
      # redirect_to customer_path()
    end
  end

  #PUT REQUEST INVALID DATA
  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { put 'http://localhost:3000/customers/:id', params: {customer: customer_attributes}
      }.to_not change(Customer, :count)
      expect(response.status).to eq(302)
    end
  end
  
  #DELETE REQUEST
  describe "delete a customer record" do
    it "deletes a customer record" do
      customer = FactoryBot.create(:customer)
      expect {delete customer_path( id: customer.id)  }.to change(Customer, :count)

      expect(response).to redirect_to customers_path
      # expect(response.status).to eq(200)
    end
  end
end
