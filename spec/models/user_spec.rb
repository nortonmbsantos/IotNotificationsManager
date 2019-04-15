require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }
  
  it { expect(@user).to respond_to(:email)  }
end
