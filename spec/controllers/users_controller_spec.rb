require 'spec_helper'

describe UsersController do
  describe "GET avatar" do
    context "when the referer has an id" do
      before do
        @user = User.create(:name => "Dog Lady")
        @user.create_avatar(
          :small_path => "app/assets/images/dfp/small.jpg",
          :medium_path => "app/assets/images/dfp/medium.jpg",
          :large_path => "app/assets/images/dfp/large.jpg")
        request.stub(:env).and_return({"HTTP_REFERER" => "http://localhost:3000/user/#{@user.id}"})
        controller.stub(:render)
      end

      it "finds the user" do
        get :avatar, :size => :small
        assigns(:user).should == @user
      end

      it "renders the small avatar for the user" do
        controller.should_receive(:send_file).with("#{Rails.root}/app/assets/images/dfp/small.jpg")
        get :avatar, :size => :small
      end

      it "renders the medium avatar for the user" do
        controller.should_receive(:send_file).with("#{Rails.root}/app/assets/images/dfp/medium.jpg")
        get :avatar, :size => :medium
      end

      it "renders the large avatar for the user" do
        controller.should_receive(:send_file).with("#{Rails.root}/app/assets/images/dfp/large.jpg")
        get :avatar, :size => :large
      end
    end
    context "when there is no referer" do
      it "renders a 404" do
        get :avatar, :size => :large
        response.status.should == 404
      end
    end

    context "when there is an invalid referer" do
      it "renders a 404" do
        request.stub(:env).and_return({"HTTP_REFERER" => "http://localhost:3000/public/user/9999999999999999"})
        get :avatar, :size => :large
        response.status.should == 404
      end
    end
  end
end
