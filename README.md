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

To add a new file to be scanned simple specify the name of the column in your model:

```ruby
  scan_file :attachment
```

and run

```console
rails generate vigilion:scan Model attachment
```

Replace `Model` with the class name which contains the attachment. And replace `attachment` with your particular file column.

## Models and callbacks

Vigilion creates an `on_scan_attachment` callback in your model which
updates the column `attachment_scan_results` column.

You can override the scan results column with:

```ruby
  scan_file :attachment, scan_column: "any_column_name"
```

But you can also replace entirely the `on_scan_attachment` method in your model.
In that case, you have to implement the logic to handle the scan results.
