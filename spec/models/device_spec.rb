require 'rails_helper'

RSpec.describe Device, type: :model do

  let(:device){build(:device)}

  context 'Validates presence of Device columns' do
    it {expect(device).to validate_presence_of(:name)}        
    it {expect(device).to validate_inclusion_of(:status).in_array([true, false])}
    it {expect(device).to validate_presence_of(:description)}        
    it {expect(device).to validate_presence_of(:address)}        

  end

end
