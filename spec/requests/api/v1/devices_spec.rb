require 'rails_helper'

RSpec.describe 'Devices API', type: :request do
  let!(:device){create(:device)}
  let(:device_id){device.id}

  describe 'GET devices/id' do
    before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        get "/devices/#{device_id}", params: {}, headers: headers
      end
  
    context 'when the device is returned' do
      it 'return device json' do
        device_response = JSON.parse(response.body)
        expect(device_response['id']).to eq(device_id)             
      end
      
      it 'return 200 code' do
        expect(response).to have_http_status(200)  
      end
    end
  
    
    context 'when the device is not returned' do
        let(:device_id){404}
        it 'return code 404' do
        expect(response).to have_http_status(404)  
      end
    end
    
  end
  

  describe 'POST /devices' do
    before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        post "/devices", params: {device: device_params}, headers: headers
      end

      context 'when the device is successfully created' do
        let(:device_params) { FactoryBot.attributes_for(:device) }
        
        it 'return the device json' do
          device_response = JSON.parse(response.body)
          expect(device_response['name']).to eq(device_params[:name])
          expect(device_response['description']).to eq(device_params[:description])
          expect(device_response['address']).to eq(device_params[:address])

        end
        
        it 'returns 201 code' do
          expect(response).to have_http_status(201)  
        end
      end

  
      context 'when the device us not created' do
        let(:device_params) { FactoryBot.attributes_for(:device, name: '') }
        
        it 'returns 422 code' do
          expect(response).to have_http_status(422)   
        end

        it 'returns the json errors' do
          device_response = JSON.parse(response.body)
          expect(device_response).to have_key('errors')  
        end
      end
    end

    describe 'PUT /devices/id' do
      before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        put "/devices/#{device_id}", params: {device: device_params}, headers: headers
      end

      context 'when the device is successfuly updated' do
        let(:device_params) {{name: 'My water sensor'}} 

        it 'returns code 200' do
         expect(response).to have_http_status(200)  
        end
        
        it 'returns the updated device json' do
          device_response = JSON.parse(response.body)
          expect(device_response['name']).to eq(device_params[:name])  
        end
      end
      
      context 'when the device is not updated' do
        let(:device_params){{name: nil}}
        it 'returns 422 code' do
          expect(response).to have_http_status(422)    
        end

        it 'returns json errors key' do
          device_response = JSON.parse(response.body)
          expect(device_response).to have_key('errors')  
        end
      end  
    end

    describe 'DELETE /devices/id' do
      before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        delete "/devices/#{device_id}", params: {device: device_params}, headers: headers
      end

      context 'when the device is deleted' do
        let(:device_params) { FactoryBot.attributes_for(:device, visible: false) }

        it 'returns 200 code' do
          expect(response).to have_http_status(200)  
        end

        it 'it updates the visible attribute to false' do
          device_response = JSON.parse(response.body)
          expect(device_response['visible']).to eq(false)  
        end
      end
      
    end
    
  

end