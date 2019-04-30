require 'rails_helper'

RSpec.describe 'Notifications API', type: :request do
  
  let!(:device){create(:device)}
  let!(:notification){create(:notification, device_id: device.id)}
  let(:notification_id){notification.id}
  

  describe 'GET notification/id' do
    before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        get "/notifications/#{notification_id}", params: {}, headers: headers
      end

      context 'when the notification is returned' do
        it 'returns 200 code' do
          expect(response).to have_http_status(200)  
        end

        it 'returns the json' do
          notification_response = JSON.parse(response.body)
          expect(notification_response['id']).to eq(notification_id)  
        end
      end

      context 'when the notification is not returnd' do
        let(:notification_id) { 404 } 
        it 'returns 404 code' do
          expect(response).to have_http_status(404)  
        end
      end 
    end
  
    describe 'POST /notifications' do
      before do
        headers = {'Accept'=> 'application/vnd.iotnotifiationmanager.v1' }
        post "/notifications", params: {notification: notification_params}, headers: headers
      end

      context 'When the notification is successfuly saved' do
        let(:notification_params){FactoryBot.attributes_for(:notification, device_id: device.id)}

        it 'returns 201 code' do
          expect(response).to have_http_status(201)   
        end
        
        it 'returns the notification json' do
          notification_response = JSON.parse(response.body)
          expect(notification_response['message']).to eq(notification_params[:message])
        end
      end

      context 'when the notification is not saved' do
        let(:notification_params){FactoryBot.attributes_for(:notification, message: nil)}

        it 'returns code 422' do
          expect(response).to have_http_status(422)             
        end

        it 'returns json key errors' do
          notification_response = JSON.parse(response.body)
          expect(notification_response).to have_key('errors') 
        end
      end
    end
    


end