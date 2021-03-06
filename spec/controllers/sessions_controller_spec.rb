require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the new template for unauthenticated users' do
      get :new
      expect(response).to render_template :new
    end

    it 'renders to the home page for authenticated users' do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do
    let(:alice) { Fabricate(:user) }

    context 'with valid credentials' do
      before do
        post :create, params: { email: alice.email, password: alice.password }
      end

      it 'puts the signed in user in the session' do
        expect(session[:user_id]).to eq(alice.id)
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to home_path
      end

      it 'sets the success flash message' do
        expect(flash[:success]).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: { email: alice.email, password: alice.password + 'something' }
      end

      it 'does not put the signed in user in the session' do
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the sign in page' do
        expect(response).to redirect_to sign_in_path
      end

      it 'sets the error flash message' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe 'GET destroy' do
    before do
      set_current_user
      get :destroy
    end

    it 'clears the session for the user' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the front page' do
      expect(response).to redirect_to root_path
    end

    it 'sets the notice' do
      expect(flash[:success]).not_to be_blank
    end
  end
end
