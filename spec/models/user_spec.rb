require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){build(:user)}

    context 'Validates presence of User columns' do
      it {expect(user).to validate_presence_of(:email)}        
      it {expect(user).to validate_confirmation_of(:password)}        
    end
  

end
