# Leña [![Gem Version](https://badge.fury.io/rb/lena.png)](http://badge.fury.io/rb/lena) [![Build Status](https://secure.travis-ci.org/wbyoung/lena.png)](http://travis-ci.org/wbyoung/lena) [![Code Review](https://codeclimate.com/github/wbyoung/lena.png)](https://codeclimate.com/github/wbyoung/lena) [![Code Coverage](https://coveralls.io/repos/wbyoung/lena/badge.png)](https://coveralls.io/r/wbyoung/lena)

Leña generates reports of client-side JavaScript errors in production Rails applications by sending error details to the server. This allows for better tracking of errors that occur in front-end code.

## Installation

Add `lena` to your `Gemfile`, then `bundle install`.

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
<%= javascript_include_tag "application", :data => lena.configuration %>
```

## Usage Client Side

Leña will now track all exceptions that are thrown in your application. You can also use Leña to log individual errors without throwing an exception. In your JavaScript, simply:

```javascript
lena.log('My Error Message')
```

## Usage Server Side

Leña will throw an exception, `Lena::ClientError`, when it receives a log message. Why? Because you're probably already using [some](http://www.exceptional.io) [sort](https://airbrake.io) [of](https://github.com/errbit/errbit) [error](https://www.honeybadger.io) [reporting](https://github.com/smartinez87/exception_notification). Also that's basically what's happening on the client side, so why not throw an exception on the server?

If you need to configure what Leña does, you can add an initializer, `config/initializers/lena.rb`:

```ruby
Lena.setup do |config|
  config.report_handler = Proc.new do |params|
    # Custom handling of log message here
  end
end
```

## Customization

An alternative to setting up Leña on your `application.js` file is to import Leña separately. This may impact performance slightly, but it will catch compiler errors in any scripts included after it:

```erb
<%= javascript_include_tag "lena", :data => lena.configuration %>
```

It is also possible to change the way that Leña handles logging on the client side. This is done by altering the options on the JavasScript include tag:

```erb
<%= javascript_include_tag "lena", :data => lena.configuration.merge("option" => "value") %>
```

The following options are available:

 * `lena-destination` The destination to report errors. The value is one of:
    * `local` Report errors to the console (if available).
    * `remote` Report errors to the server.
    * `all` Report errors to all supported destinations (local & remote).
   This defaults to `local` during development and `all` for production & test.
 * `lena-remote-url` A url to which Leña will errors. You can change this to point to another location or service if need be.


## License

This project is distributed under the MIT license.