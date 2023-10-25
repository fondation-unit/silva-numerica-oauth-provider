# Silva Numerica Provider App

This app is an OAuth 2 provider using [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper), [Rails 7.1](http://rubyonrails.org/), MySQL and [Devise](https://github.com/plataformatec/devise).

## Doorkeeper Gem

Information [about the gem](https://github.com/doorkeeper-gem/doorkeeper), [documentation](https://github.com/doorkeeper-gem/doorkeeper#readme), [wiki](https://github.com/doorkeeper-gem/doorkeeper/wiki/_pages) and another resources : [on GitHub](https://github.com/doorkeeper-gem/doorkeeper)

## Installation

First clone the [repository from GitHub](https://github.com/doorkeeper-gem/doorkeeper-provider-app):

    git clone git@github.com:fondation-unit/silva-numerica-oauth-provider.git

Install all dependencies with:

    bin/bundle install

For production : 

    RAILS_ENV=production bin/rails assets:precompile

## Configuration

The configuration is quite simple, all you need to do is run:

    bin/rails db:setup

## OAuth endpoints

The endpoints is mounted under `/oauth` so our routes look like this:

    GET       /oauth/authorize
    POST      /oauth/authorize
    DELETE    /oauth/authorize
    POST      /oauth/token
    resources /oauth/applications

## Example API

This app provides a sample JSON API under `/api/v1`. The current API endpoints are:

    /api/v1/profiles.json
    /api/v1/me.json

In `routes.rb` you can check out how they're made:

``` ruby
namespace :api do
  namespace :v1 do
    resources :profiles
    get '/me' => "credentials#me"
  end
end
```

We namespace the API controllers to avoid name clashing and collisions between your existing application and the API.
This way, you can make changes to your application without messing up with the API's behavior.

You can find all controllers under `/app/controllers/api/v1` folder.

The `api_controller.rb` works as a parent class to the other controllers. It only defines a method that returns the current resource owner, based on the access token:

``` ruby
def current_resource_owner
  User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
end
```

This is required if you want to return data based on the current user, like in `credentials_controller.rb`

### Make Access Token Required

To make your API only available for OAuth users, you need to tell doorkeeper to require an access token in
your api controller, like this:

``` ruby
module Api::V1
  class ProfilesController < ApiController
    before_action :doorkeeper_authorize!

    def index
      render json: Profile.recent
    end
  end
end
```

Or:

``` ruby
module Api::V1
  class ProjectsController < ApiController
    before_action -> { doorkeeper_authorize! :read }, only: %i[index show]
    before_action -> { doorkeeper_authorize! :write }, only: %i[create update destroy]

    def index
      render json: current_resource_owner.projects
    end
  end
end
```

However, see also the Doorkeeper wiki article about [using scopes](https://github.com/doorkeeper-gem/doorkeeper/wiki/Using-Scopes).

If you attempt to access any of the protected resources without an proper access token, you'll get an `401 Unauthorized` response.

## Assets

Include `doorkeeper/application.css` and `doorkeeper/admin/application.css` in `app/assets/config/manifest.js`, like this:

``` js
//= link_tree ../images
//= link_tree ../../javascript .js
//= link_tree ../builds
//= link doorkeeper/application.css
//= link doorkeeper/admin/application.css
```

## Client applications

You can manage all client applications in `/oauth/applications`.

## Usage with Moodle

### In the provider

Configure a new application in the administration with the Moodle callback URL : `/admin/oauth2callback.php`

### In Moodle

1. Enable the OAuth authentication plugin
2. Under `Server > Services OAuth 2` declare a new Custom service
3. Fill in the settings :

|Keys|Values|
|----|------|
|Name|****|
|Client ID|****|
|Client Secret|****|
|Service base URL|****|
|This service will be used|Login page and internal services|
|Scopes included in a login request|read|
|Scopes included in a login request for offline access|read|
|Require email verification|true|

4. Under `Configure Endpoints (/admin/tool/oauth2/endpoints.php)` declare the following endpoints :

|Keys|Values|
|----|------|
|discovery_endpoint|https://doorkeeper.mydomain.com/oauth/applications|
|authorization_endpoint|https://doorkeeper.mydomain.com/oauth/oauth/authorize|
|token_endpoint|https://doorkeeper.mydomain.com/oauth/oauth/token|
|revocation_endpoint|https://doorkeeper.mydomain.com/oauth/revoke|
|userinfo_endpoint|https://doorkeeper.mydomain.com/api/v1/me.json|

5. Configure the `User fields mapping /admin/tool/oauth2/userfieldmappings.php` :

|Keys|Values|
|----|------|
|firstname|firstname|
|lastname|firstname|
|email|email|

## Usage with API

1. POST request to the token endpoint to get the access_token :

`POST : https://uri.../oauth/token`

`Body : Multipart Form`

|Keys|Values|
|----|------|
|client_id|********|
|client_secret|********|
|grant_type|password|
|username|email@example.com|
|password|********|

The response should be in like this :

```json
{
  "access_token": "kdrfVrw8HInqhUweeBnZoDJD8Cm4UXE3QeQt9rSnqZR",
  "token_type": "Bearer",
  "expires_in": 7200,
  "refresh_token": "POadph1Enla7Fxy3GpgO7zk8o7U0Zyg9xDwimCP0PsB",
  "scope": "read",
  "created_at": 1697190055
}
```

2. GET request to the credentials endpoint :

`GET : https://uri.../api/v1/me.json`

Headers : `authorization Bearer kdrfVrw8HInqhUweeBnZoDJD8Cm4UXE3QeQt9rSnqZR`
