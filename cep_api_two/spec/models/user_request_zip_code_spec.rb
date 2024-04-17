require 'rails_helper'

RSpec.describe UserRequestZipCode, type: :model do
  let(:user_request_zip_code) { FactoryBot.create(:user_request_zip_code) }

  context 'with should attributes response' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:zip_code_id) }
  end

  context 'with should relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:zip_code) }
  end
end
