# Leña [![Gem Version](https://badge.fury.io/rb/lena.png)](http://badge.fury.io/rb/lena) [![Build Status](https://secure.travis-ci.org/wbyoung/lena.png)](http://travis-ci.org/wbyoung/lena) [![Code Review](https://codeclimate.com/github/wbyoung/lena.png)](https://codeclimate.com/github/wbyoung/lena) [![Code Coverage](https://coveralls.io/repos/wbyoung/lena/badge.png)](https://coveralls.io/r/wbyoung/lena)

Leña provides simple server-side JavaScript error logging for production Rails applications. This allows you to better track errors that occur in your front-end code.

## Installation

Add `lena` to your `Gemfile`, then `bundle install`:

```ruby
gem 'lena'
```

Add the following to your `application.js`:

```javascript
//= require lena
```

Add the following to your `routes.rb`:

```ruby
mount Lena::Engine => "/lena"
```

Update your `application.html.erb`:

```erb
<%= javascript_include_tag "application", lena.configuration %>
```

If you use Turbolinks or provide other options for your javascript include, you can merge them: `lena.configuration.merge("data-something" => true)`.

## Usage Client Side

Leña will now track all exceptions that are thrown in your application. You can also use Leña to log individual errors without throwing an exception. In your JavaScript, simply:

```javascript
lena.log('My Error Message')
```

## Usage Server Side

Leña will simply throw an exception, `Lena::JavaScriptError`, when it receives a log message. Why? Because you should be using {something}[https://github.com/smartinez87/exception_notification] to report server errors when they occur. Also that's basically what's happening on the client side, so why not throw an exception on the server?

If you need to configure what Leña does, you can add `config/initializers/lena.rb`:

```ruby
Lena.setup do |config|
  config.javascript_handler = Proc.new do |params|
    # Custom handling of log message here
  end
end
```

## Alternative Setup

An alternative to setting up Leña on your `application.js` file is to import Leña separately. This may impact performance, but it will catch compiler errors in any scripts included after it:

```erb
<%= javascript_include_tag "lena", lena.configuration %>
```

## License

This project is distributed under the MIT-LICENSE.