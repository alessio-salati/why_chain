# WhyChain

A tiny gem to inspect Ruby method dispatch at runtime.

WhyChain helps you see:
- method lookup chain (`ancestors`)
- method owner resolution
- where `super` would resolve next

Built for learning and debugging Ruby internals. Not a production framework.

You can inspect this manually in Ruby console, but WhyChain gives you a consistent, teachable trace in one call.

## Installation

Add the gem to your `Gemfile`:

```ruby
gem "why_chain"
```

Then run:

```bash
bundle install
```

## Quick start

```ruby
trace = WhyChain.trace(object, :method_name)
pp trace.to_h

puts WhyChain.explain(object, :method_name)
```

`trace` is a `WhyChain::DispatchTrace` object with readers:
- `lookup_chain`
- `owner`
- `next_super_owner`
- `source_location`
- `steps` (`WhyChain::DispatchStep` objects)

As hash:

```ruby
trace.to_h
# {
  lookup_chain: [...],
  owner: SomeClassOrModule,
  next_super_owner: AnotherClassOrModule,
  source_location: ["file.rb", 12],
  steps: [
    { owner: SomeClassOrModule, source_location: ["file.rb", 12] }
  ]
# }
```

`WhyChain.explain` returns a human-readable dispatch explanation:

```ruby
puts WhyChain.explain(B.new, :foo)
# Ruby dispatch explanation for :foo
#
# 1. P#foo
#    defined at:
#    /path/to/file.rb:12
#
#    calls super ->
#
# 2. A#foo
#    defined at:
#    /path/to/file.rb:7
```

## Usage examples

### 1) `prepend` vs `include` in runtime lookup

```ruby
module P
  def foo = :p
end

module I
  def foo = :i
end

class A
  def foo = :a
end

class B < A
  include I
  prepend P
end

trace = WhyChain.trace(B.new, :foo)
pp trace.to_h
# {
#   lookup_chain: [P, B, I, A, Object, Kernel, BasicObject],
#   owner: P,
#   next_super_owner: I
# }
```

### 2) Singleton method takes precedence

```ruby
obj = Object.new
def obj.single_foo = :singleton

trace = WhyChain.trace(obj, :single_foo)
pp trace.to_h
# {
#   lookup_chain: [#<Class:#<Object:...>>, Object, Kernel, BasicObject],
#   owner: #<Class:#<Object:...>>,
#   next_super_owner: nil
# }
```

### 3) Missing method fails fast

```ruby
WhyChain.trace(Object.new, :not_existing_method)
# raises NameError
```

Note: some entries in `lookup_chain` can appear as anonymous classes/modules (for example singleton classes). This is expected and reflects Ruby runtime internals.

## Development

Run tests:

```bash
bundle exec rspec
```

Run lint:

```bash
bundle exec rubocop
```

## Contributing

Bug reports and pull requests are welcome on GitHub:
[https://github.com/alessio-salati/why_chain](https://github.com/alessio-salati/why_chain)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
