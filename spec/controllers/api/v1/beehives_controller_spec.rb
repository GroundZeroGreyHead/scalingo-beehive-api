require 'rails_helper'

RSpec.describe Api::V1::BeehivesController, type: :controller do
  
  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new beehive" do
        expect {
          post :create, params: { beehive: { name: "New Hive", weight: 80 } }
        }.to change(Beehive, :count).by(1)
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end

      it "returns the newly created beehive in JSON format" do
        post :create, params: { beehive: { name: "New Hive", weight: 80 } }
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)["name"]).to eq("New Hive")
      end
    end

    context "with invalid attributes" do
      it "returns an unprocessable entity status for invalid name" do
        post :create, params: { beehive: { weight: 80 } }
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end

      it "returns an unprocessable entity status for invalid weight" do
        post :create, params: { beehive: { name: "New Hive" } }  # Missing weight
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["weight"]).to include("can't be blank")
      end
    end
  end

  describe "GET #index" do
    before { create_list(:beehive, 100) }

    it "returns a successful response" do
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
    
    it "returns beehives in JSON format" do
      get :index
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
    
    it 'returns paginated list of beehives' do
      get :index, params: { page: 5 }

      json_response = JSON.parse(response.body)
      expect(json_response['beehives'].size).to eq(10)
      expect(json_response['meta']['current_page']).to eq(5)
    end
  end

  describe "GET #show" do
    let(:beehive) { create(:beehive) }

    it "returns a successful response for a valid beehive" do
      get :show, params: { id: beehive.id }
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "returns a JSON representation of the beehive" do
      get :show, params: { id: beehive.id }
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(JSON.parse(response.body)["id"]).to eq(beehive.id)
    end

    it "returns a not found error for a non-existent beehive" do
      get :show, params: { id: 0 } 
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)["error"]).to eq("Beehive not found")
    end

  end
end
