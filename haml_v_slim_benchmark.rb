require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'
require 'action_view'
include Benchmark
include ActionView::Helpers
include ActionView::RoutingUrlFor

# SETUP

def title(round, caption)
  "\n#{round}. #{caption}\n#{' ' * 10}#{CAPTION}"
end

class Person
  attr_reader :first_name, :last_name, :age
  def initialize(options)
    @first_name = options[:first_name]
    @last_name = options[:last_name]
    @age = options[:age]
  end
end

person = Person.new(first_name: 'Tomek', last_name: 'Nowak', age: 30)

html1 = Tilt.new('views/1.html')
haml1 = Tilt.new('views/1.haml')
slim1 = Tilt.new('views/1.slim')

html2 = Tilt.new('views/2.html')
haml2 = Tilt.new('views/2.haml')
slim2 = Tilt.new('views/2.slim')

haml3 = Tilt.new('views/3.haml')
slim3 = Tilt.new('views/3.slim')

haml4 = Tilt.new('views/4.haml')
slim4 = Tilt.new('views/4.slim')

haml5 = Tilt.new('views/5.haml')
slim5 = Tilt.new('views/5.slim')

# BENCHMARKS

puts "\n4 TESTS, 100_000 ITERATIONS EACH\n"

Benchmark.benchmark(title(1, 'EMPTY FILES'), 10, FORMAT) do |x|
  x.report('1html:') do
    100_000.times { html1.render }
  end

  x.report('1haml:') do
    100_000.times { haml1.render }
  end

  x.report('1slim:') do
    100_000.times { slim1.render }
  end
end

Benchmark.benchmark(title(2, 'FILES WITH STATIC CONTENT'), 10, FORMAT) do |x|
  x.report('2html:') do
    100_000.times { html2.render }
  end

  x.report('2haml:') do
    100_000.times { haml2.render }
  end

  x.report('2slim:') do
    100_000.times { slim2.render }
  end
end

Benchmark.benchmark(title(3, 'RUBY FOR AND WHILE LOOPS, 2 x 100'), 10, FORMAT) do |x|
  x.report('3haml') do
    100_000.times { haml3.render }
  end

  x.report('3slim') do
    100_000.times { slim3.render }
  end
end

Benchmark.benchmark(title(4, 'ACTIONVIEW HELPERS'), 10, FORMAT) do |x|
  x.report('4haml') do
    100_000.times { haml4.render }
  end

  x.report('4slim') do
    100_000.times { slim4.render }
  end
end

Benchmark.benchmark(title(5, 'VARIABLES'), 10, FORMAT) do |x|
  x.report('5haml') do
    100_000.times { haml5.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end

  x.report('5slim') do
    100_000.times { slim5.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end
end
