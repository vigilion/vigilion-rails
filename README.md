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
You need to replace the default APIKEY with the one you obtained in http://vigilion.com/

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

vigilion-rails provides carrierwave and paperclip integration out-of-the-box.
That means that simply adding the `scan_file` command to your model, each time a new file is uploaded, a scanning process will be automatically scheduled.

## Models and callbacks

Vigilion creates an `on_scan_attachment` callback in your model which
updates the column `attachment_scan_results` column.

You can override the scan results column with:

```ruby
  scan_file :attachment, scan_column: "any_column_name"
```

You can also replace entirely the `on_scan_attachment` method in your model.
In that case, you have to implement the logic to handle the scan results.
