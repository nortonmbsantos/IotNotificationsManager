require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user){create(:user)}
  let(:user_id){user.id}

  before {host! 'api.iotnotificationmanager.dev'}

  describe 'GET users/id' do
    before do
      headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'when the user is returned' do
      it 'success' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:id]).to eq(user_id)  
      end

      it 'return 200 code' do
        expect(response).to have_http_status(200)
      end
      
    end
  
    context 'when the user is not returned' do
        let(:user_id){22}
        
        it 'returns 404 code' do
          expect(response).to have_http_status(404)            
        end
    end
  end

  describe 'POST /users' do
    before do
      headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
      post '/users', params: {user: user_params}, headers: headers
    end
    
    context 'when the resquest is valid' do
      let(:user_params){FactoryBot.attributes_for(:user)}
      
      it 'returns 201 code' do   
        expect(response).to have_http_status(201)  
      end

      it 'returns user params on JSON' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'when the request is invalid' do
      let(:user_params){attributes_for(:user, email: 'invalid_email@')}
      it 'returns 422 code' do
        expect(response).to have_http_status(422)          
      end

      it 'returns the error on json' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)           
      end
      
    end
    
  end

  describe 'PUT /users/:id' do
    before do
      headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
      put "/users/#{user_id}", params: {user: user_params}, headers: headers
    end

    context 'when the resquest is valid' do
      let(:user_params){{email: 'newemail@email.com'}}
      it 'returns 200 code' do
        expect(response).to have_http_status(200)  
      end
        
      it 'returns the updated user json' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'when the request is invalid' do
      let(:user_params){{email: 'invalid_email@'}}
      it 'returns 422 code' do
        expect(response).to have_http_status(422)  
      end
        
      it 'returns the update error on json' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)           
      end      
    end
  end
  
  describe 'DELETE /users/:id' do
    before do
      headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
      delete "/users/#{user_id}", params: {}, headers: headers
    end

    it 'returns 204 code' do
      expect(response).to have_http_status(204)    
    end
    
    it 'removes the user from the database' do
      expect(User.find_by(id: user_id)).to be_nil
    end
    

  end
  

end
