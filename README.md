# Vigilion Rails
Rails engine for Vigilion - Virus Scanning Service

## Getting started

You can add Vigilion Rails to your Gemfile with:

```ruby
gem 'vigilion-rails'
```

Run the bundle command to install it.

After you install vigilion-rails and add it to your Gemfile, you need to run the generator:

```console
rails generate vigilion:install
```

The generator will install an initializer which describes Vigilion configuration options.
You need to set the api key with the value you obtained in http://vigilion.com/

To add a new file to be scanned simply specify the name of the column in your model:

```ruby
  scan_file :attachment
```

and run

```console
rails generate vigilion:scan Model attachment
```

Replace `Model` with the class name which contains the attachment. And replace `attachment` with your particular file column.

## Manually triggered scans

Supposing you have an attribute called `attachment` in your model:
To scan a file, just call `model.scan_attachment!`.
When the scan finishes, `model.attachment_scan_results` will be updated.

## Integrations

**vigilion-rails** provides **paperclip**, **carrierwave** and
**dragonfly** integration out-of-the-box. That means that
simply adding the `scan_file` command to your model, each time
a new file is uploaded, a scanning process will be
automatically scheduled.

Independently of the gem you use to upload files, there are two
integration strategies:

### URL integration

It sends `model.attachment.url` to the Vigilion's server. The
server uses this URL to download the file and perform the
scanning process. `attachment.url` must be an absolute path.
Use this integration with S3 and other storage services.

This is the default integration, so no additional configuration
is needed, but you can also explicitly configure it adding the
following option:

```ruby
  scan_file :attachment, integration: :url
```

### Local integration

This integration takes a local file path, reads the content of
the file and post it to the Vigilion's servers. The server
creates a temporary file with the content which will be deleted
after the scanning process is performed.

To configure local integration, add the following option to the scan_file
method:
```ruby
  scan_file :attachment, integration: :local
```

### Custom integrations

To support other integrations or custom integrations create a
new class:

```ruby
module VigilionRails
  class CustomIntegration
    def scan(key, model, column)
      # Put your custom code here!!!
      # You can use Vigilion.scan_path or Vigilion.scan_url
    end
  end
end
```

And put it in place using:
```ruby
  scan_file :attachment, integration: :custom
```

To know how to make direct calls to Vigilion API visit
https://github.com/vigilion/vigilion-ruby

## Models and callbacks

Vigilion creates an `on_scan_attachment` callback in your model
which updates the column `attachment_scan_results` column when
the application receives the scan results from Vigilion.

You can override the scan results column with:

```ruby
  scan_file :attachment, scan_column: "any_column_name"
```

You can also replace entirely the `on_scan_attachment` method
in your model. In that case, you have to implement the logic to
handle the scan results.

## Loopback

Due to the fact that **vigilion** requires an URL to make the
scanning callback to send the results, there is no sense in
calling vigilion from a non public location.
Using a loopback, you can simulate the success or failure of
a scan in a private location.

By default, the loopback is active in development and test
environments and disabled in any other environment.
You can alter the defaults an also alter the default response
in the initializer:

To disable the loopback on any environment (and therefore
enable the vigilion call) use:
```ruby
  config.loopback = false
```
To enable the loopback (and disable the vigilion call) use:
```ruby
  config.loopback = true
```

You can also specify the loopback response:
```ruby
  config.loopback_response = 'infected'
```

(c) 2015 BitZesty Ltd.
