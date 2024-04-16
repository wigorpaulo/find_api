require 'rails_helper'

RSpec.describe ZipCodesController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/zip_codes/1').to route_to('zip_codes#show', id: '1')
    end
  end
end
