require 'rails_helper'

RSpec.describe '/users', type: :request do

  describe 'GET /index' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:token) { JWT.encode({ user_id: user.id, exp: 5.seconds.from_now.to_i }, Rails.application.secret_key_base) }

    context 'with user authenticate' do
      before do
        get users_url, headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with header Authorization is token type error' do
      before do
        get users_url, headers: { Authorization: token }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with header Authorization is token nil' do
      before do
        get users_url, headers: { Authorization: nil }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with user authenticate and expired token' do
      before do
        sleep(7.seconds)
        get users_url, headers: { Authorization: "Bearer #{token}" }
      end

      it 'response status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create_token' do
    let!(:user) { FactoryBot.create(:user) }

    context 'with valid parameters' do
      before do
        post create_token_url, params: { email: user.email, password: 'password' }
      end

      it 'responses status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with valid parameters and user not authenticate' do
      before do
        post create_token_url, params: { email: user.email, password: user.password_digest }
      end

      it 'responses status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with parameters email is nil' do
      before do
        post create_token_url, params: { email: nil, password: user.password_digest }
      end

      it 'responses status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with parameters password is nil' do
      before do
        post create_token_url, params: { email: user.email, password: nil }
      end

      it 'responses status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
