require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){build(:user)}
  
  # context "When user is valid" do
  #   it { expect(user).to respond_to(:email)  }
  #   it { expect(user).to be_valid  }
  # end
  
  # context "When email is blank" do
  #   before{ user.email = ''}
  #   it { expect(user).to_not be_valid  }
  # end
  
  # context "When email is nil" do
  #   before{ user.email = nil}
  #   it { expect(user).to_not be_valid  }
  # end

    context "Validates presence of User columns" do
      it {expect(user).to validate_presence_of(:email)}        
      it {expect(user).to validate_confirmation_of(:password)}        
    end
  

end
