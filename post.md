## Serving up different sized dynamic images based on device resolutions. ##

[Jason](http://pivotallabs.com/users/jnoble/blog/) and I were working on an app where we needed to render dynamic images of several different sizes for different mobile devices, depending on device resolution.

Our scenario was analagous to the following:

Let's say you are an engineer for Twitter and you need to display a users avatar on their show page, but you need to serve a small, medium, or large image based on the resolution of the device accessing the page.
This was a good candidate for CSS media queries, except that the image url needed to be obtained from our User object (in Ruby). We decided to cross that bridge when we got there and spike on an initial proof-of-concept.

#### users#show view ####

    <h2><%= @user.name %></h2>
    <div class="avatar"></div>
    # ...

#### stylesheet ####

    /* Default - screens over 767px wide */
    .avatar {
      /* ... */
      width: 220px;
      height: 220px;
      background: url('/assets/dfp/large.jpg');
    }

    /* Mobile Landscape */
    @media only screen and (min-width: 480px) and (max-width: 767px) {
      .avatar {
        /* ... */
        width: 140px;
        height: 197px;
        background: url('/assets/dfp/medium.jpg');
      }
    }

    /* Mobile portrait */
    @media only screen and (max-width: 479px) {
      .avatar {
        /* ... */
        width: 60px;
        height: 85px;
        background: url('/assets/dfp/small.jpg');
      }
    }

Pretty straightforward stuff, especially if you've followed the Responsive Web Design (CSS media queries) trend.
The interesting thing to note here, is that when putting the background image in the stylesheet, the asset does not get requested until you resize your browser to the size that uses that image.
Go ahead and load [this page](http://responsive-static-avatar-demo.herokuapp.com/) in a web browser, open up the network panel, resize the display and watch the asset size change and different requests get fired off. That's exactly what we wanted!

Okay, great, but, although it would be glorious, not everyone is going to have Dog Fanny Pack for their avatar. We need to call some ruby method on some ruby object to get the image (e.g. user.avatar.url).
Not really something you can do from within the stylesheet. Alternatively you wouldn't want to move the background image reference to the view because then it get's loaded as soon as the page loads regardless of the screen resolution.

We decided to create a little proxy. See below:

#### Routes ####

    ResponsiveUserAvatar::Application.routes.draw do
      # ...
      match "users/avatars/:size.jpg" => "users#avatar"
    end

#### Users controller ####

    def avatar
      user = get_user
      size = params[:size]
      if user.present?
        send_file "#{Rails.root}/#{user.avatar.url(size)}"
      else
        render :status => :not_found, :text => "not found"
      end
    end


We created an action, called avatar, on our users controller (you could do a seperate avatar controller too) that takes a size parameter. The avatar action first looks up the user (You don't get to see how 'till later),
then it grabs the size from the url and renders the user's avatar for that size. You will notice this action isn't really on the member (i.e. no user id), even though it should be, we'll get to that in a second.
You may also be thinking of alternatives to using send_file. We experimented with redirects, but ran into caching issues. I am open to suggestion on these topics, so feel free to post suggestions in the comments or [submit a pull request to the demo app](http://responsive-user-avatar-demo.herokuapp.com/).

Now all we have to do is call our proxy image/action in the stylesheet, see below:

#### users.css ####

    /* Default - screens over 767px wide */
    .avatar {
      /* ... */
      background: url('/users/avatars/large.jpg');
    }

    /* Mobile Landscape */
    @media only screen and (min-width: 480px) and (max-width: 767px) {
      .avatar {
        /* ... */
        background: url('/users/avatars/medium.jpg');
      }
    }

    /* Mobile portrait */
    @media only screen and (max-width: 479px) {
      .avatar {
        /* ... */
        background: url('/users/avatars/small.jpg');
      }
    }

## Coming clean... ##

So, I left out one minor detail... Okay major detail... It's time to show the implementation of the "get_user" method.

#### users_controller ####

    class UsersController < ApplicationController
      # ...
      private

      def get_user
        if request.env["HTTP_REFERER"].present?
          user_id = request.env["HTTP_REFERER"].match(/\/(\d+)\/?/)[1]
          user = User.find_by_id(user_id)
        end
      end
    end

In our case we always had the user id in the page that used the avatar. If we tried to implement this on the listing page, well it wouldn't be pretty.

While this isn't a silver bullet solution, it's a cool concept and can be applied to many different applications. I call it the "responsive-css-background-fake-image-proxy" pattern.
Okay, maybe not, but to recap the main components are:

1. Use CSS media queries to target different device resolutions.
2. Reference the background-image proxy url in the stylesheet, which only loads the image size needed.
3. Use a fake image proxy to get your dynamic image.

[Demo app](http://responsive-user-avatar-demo.herokuapp.com/) and [demo app code](https://github.com/alexwelch/responsive-user-avatar-demo)
