require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){build(:user)}

    context 'Validates presence of User columns' do
      it {expect(user).to validate_presence_of(:email)}        
      it {expect(user).to validate_confirmation_of(:password)}
      it {expect(user).to validate_uniqueness_of(:auth_token) }        
    end
  
    describe '#generate auth token' do
      it 'generate a unique token' do
        allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
        user.generate_auth_token!

        expect(user.auth_token).to eq('abc123xyzTOKEN')  
      end
      
    end
    
    

end
