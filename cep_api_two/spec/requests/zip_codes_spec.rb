require 'rails_helper'

RSpec.describe '/zip_codes', type: :request do

  describe 'GET /show' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:token) { JWT.encode({ user_id: user.id, exp: 5.seconds.from_now.to_i }, Rails.application.secret_key_base) }

    context 'with user authenticate and exist base zip_code' do
      let!(:zip_code) { FactoryBot.create(:zip_code) }

      before do
        get zip_code_url(zip_code.zip_code), headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with user authenticate and zip_code not found' do
      let!(:zip_code) { FactoryBot.create(:zip_code) }

      before do
        get zip_code_url(zip_code.id), headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with user authenticate and zip_code not exist base' do
      before do
        get zip_code_url(74463500), headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with header Authorization is token type error' do
      before do
        get zip_code_url(74463500), headers: { Authorization: token }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with header Authorization is token nil' do
      before do
        get zip_code_url(74463500), headers: { Authorization: nil }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with user authenticate and expired token' do
      before do
        sleep(7.seconds)
        get zip_code_url(74463500), headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
