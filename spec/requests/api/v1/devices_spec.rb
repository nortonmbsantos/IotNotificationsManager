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
      
  end
  



end