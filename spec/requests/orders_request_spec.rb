require 'rails_helper'

RSpec.describe "Orders", type: :request do
  #GET REQUESTS
  describe "GET /index" do
    it "returns index success" do
      get orders_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns show success" do
      order = FactoryBot.create(:order)
      get order_path(id: order.id)
      expect(response).to have_http_status(:success)
    end
    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end

  describe "GET /new" do
    it "returns new success" do
      order = FactoryBot.create(:order)
      get new_order_path(id: order.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      order = FactoryBot.create(:order)
      get edit_order_path(id: order.id)
      expect(response).to have_http_status(:success)
    end
  end

    #POST PUT DELETE REQUESTS

  #POST REQUEST VALID DATA
    describe "Post orders_path with valid data" do
      it "saves new order entry and redirects to that entry show page" do
        customer = FactoryBot.create(:customer)
        order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
        order_attributes[:customer_id] = customer.id
        expect { post orders_path, params: {order: order_attributes}
      }.to change(Order, :count)

        #get the last Order's id (new order)
        expect(response).to redirect_to order_path(id: Order.last.id)
      end
    end

  #POST REQUEST INVALID DATA
  describe "Post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      order_attributes = FactoryBot.attributes_for(:order)
      order_attributes.delete(:customer_id)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
    end
  end

    #PUT REQUEST VALID DATA
    describe "put order_path with valid data" do
      it "updates an entry and redirects to the show path for the order" do
        order = FactoryBot.create(:order)
        order_attributes = FactoryBot.attributes_for(:order)
        order_attributes[:product_name] = 'Apple'
        expect{ put order_path( id: order.id ), params:  { order: order_attributes }
        }.to change{ order.reload.product_name }
  
        expect(response).to redirect_to(order_path( id: order.id ))
        # redirect_to order_path()
      end
    end
  
    #PUT REQUEST INVALID DATA
    describe "put order_path with invalid data" do
      it "does not update the order record or redirect" do
        order_attributes = FactoryBot.attributes_for(:order)
        order_attributes.delete(:product_name)
        expect { put 'http://localhost:3000/orders/:id', params: {order: order_attributes}
        }.to_not change(Order, :count)
        expect(response.status).to eq(302)
      end
    end
    
    #DELETE REQUEST
    describe "delete a order record" do
      it "deletes a order record" do
        order = FactoryBot.create(:order)
        expect {delete order_path( id: order.id)  }.to change(Order, :count)
  
        expect(response).to redirect_to orders_path
        # expect(response.status).to eq(200)
      end
    end

end
