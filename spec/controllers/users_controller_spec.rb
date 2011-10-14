require 'spec_helper'

describe UsersController do
  describe "GET avatar" do
    it "redirects to the small avatar for the user" do
      user = User.create(:name => "Dog Lady")
      user.create_avatar(
        :small_url => "/assets/dfp/small.jpg",
        :medium_url => "/assets/dfp/medium.jpg",
        :large_url => "/assets/dfp/large.jpg")
      request.stub(:env).and_return({"HTTP_REFERER" => "http://localhost:3000/user/#{user.id}"})
      get :avatar, :size => :small
      response.should redirect_to "/assets/dfp/small.jpg"
    end

    it "redirects to the medium avatar for the user" do
      user = User.create(:name => "Dog Lady")
      user.create_avatar(
        :small_url => "/assets/dfp/small.jpg",
        :medium_url => "/assets/dfp/medium.jpg",
        :large_url => "/assets/dfp/large.jpg")
      request.stub(:env).and_return({"HTTP_REFERER" => "http://localhost:3000/user/#{user.id}"})
      get :avatar, :size => :medium
      response.should redirect_to "/assets/dfp/medium.jpg"
    end

    it "redirects to the large avatar for the user" do
      user = User.create(:name => "Dog Lady")
      user.create_avatar(
        :small_url => "/assets/dfp/small.jpg",
        :medium_url => "/assets/dfp/large.jpg",
        :large_url => "/assets/dfp/large.jpg")
      request.stub(:env).and_return({"HTTP_REFERER" => "http://localhost:3000/user/#{user.id}"})
      get :avatar, :size => :large
      response.should redirect_to "/assets/dfp/large.jpg"
    end
  end
end
