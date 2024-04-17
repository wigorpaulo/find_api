require 'rails_helper'

RSpec.describe ZipCode, type: :model do
  let(:zip_code) { FactoryBot.create(:zip_code) }

  context 'with should attributes response' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:zip_code) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:neighborhood) }
    it { is_expected.to respond_to(:city) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:complement) }
  end
end
