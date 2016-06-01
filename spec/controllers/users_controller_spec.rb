require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe ':usercontroller' do
    describe '#new' do

    end

    describe '#get' do
        it 'should return customer for given params' do
          get :index, {email:'ks@gmail.com', password: '1234569'}
          expect(response).to be_success
        end
    end
  end
end
