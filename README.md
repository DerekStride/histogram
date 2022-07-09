# Histogram
[![Ruby CI](https://github.com/DerekStride/histogram/actions/workflows/ruby.yml/badge.svg)](https://github.com/DerekStride/histogram/actions/workflows/ruby.yml) [![Publish new releases to rubygems](https://github.com/DerekStride/histogram/actions/workflows/publish-gem.yml/badge.svg)](https://github.com/DerekStride/histogram/actions/workflows/publish-gem.yml)

Easily create a histogram from an array of values and allow easy rendering to the terminal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'histogram-rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install histogram-rb

## Usage

Initialize a Histogram with a list of values:

```ruby
histogram = Histogram.new(1000.times.map { Random.rand })
```

Then call render to get a print-friendly string, all parameters are optional.

```ruby
histogram.render(
  title: "Uniform Distribution",
  precision: 2,
)
```

```
                              Uniform Distribution
═════════════════════════════════════════════════════════════════════════════════
    x                       x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
    x           x           x           x           x           x          x
─────────────────────────────────────────────────────────────────────────────────
 0.0-0.14   0.14-0.29   0.29-0.43   0.43-0.57   0.57-0.71   0.71-0.86   0.86-1.0
 (150)      (128)       (154)       (145)       (136)       (150)       (137)
```

You can use the `border` parameter to specify a `terminal-table` border class to change the output. e.g.

```ruby
histogram.render(
  title: "Normal Distribution",
  precision: 2,
  border: Terminal::Table::AsciiBorder.new,
)
```

```
                               Normal Distribution
-----------+----------+----------+-----------+-----------+-----------+-----------
                                       x
                                       x
                           x           x
                           x           x
                           x           x           x
                           x           x           x           x
                           x           x           x           x
                x          x           x           x           x
                x          x           x           x           x
     x          x          x           x           x           x           x
     x          x          x           x           x           x           x
     x          x          x           x           x           x           x
-----------+----------+----------+-----------+-----------+-----------+-----------
 0.02-0.16   0.16-0.3   0.3-0.44   0.44-0.57   0.57-0.71   0.71-0.85   0.85-0.98
 (26)        (51)       (108)      (141)       (81)        (73)        (24)
```
## Development

After checking out the repo, run `bundle install` to install dependencies. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

## Testing

Running the unit tests with `bundle exec rake test`.

The rendering portion of the histogram is harder to test with unit tests. Instead there is a script that will allow you
to render histograms easily to enable visual tests.

Examples:

`bin/test`
`bin/test -b ascii -p 2`
`bin/test -t "Example Title" -b thick -p 2`
`bin/test -t "Example Title" -b ascii -p 3`
`bin/test -t "Normal Distribution" -d normal -p 2 -c 10000`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
