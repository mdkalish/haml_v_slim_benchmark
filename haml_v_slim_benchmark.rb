require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'
require 'action_view'
include Benchmark

puts "\n7 TESTS, 100_000 ITERATIONS FOR EACH FILE (HTML, HAML, SLIM)\n"

def round_caption(round)
  [
    ' EMPTY FILES',
    ' FILES WITH STATIC CONTENT',
    ' + BOOTSTRAP CSS FROM LOCAL SSD',
    ' + BOOTSTRAP JS AND JQUERY FROM LOCAL SSD'
  ][round]
end

for i in 1..4 do # rubocop:disable Style/For

  html = Tilt.new("views/#{i}.html")
  haml = Tilt.new("views/#{i}.haml")
  slim = Tilt.new("views/#{i}.slim")

  title = "\n#{i}. #{round_caption(i - 1)}\n#{' ' * 10}#{CAPTION}"
  Benchmark.benchmark(title, 10, FORMAT) do |x|
    x.report("#{i}html:") do
      100_000.times { html.render }
    end

    x.report("#{i}haml:") do
      100_000.times { haml.render }
    end

    x.report("#{i}slim:") do
      100_000.times { slim.render }
    end
  end
end

# ROUND 5: + ruby for and while loops, 2 x 1000

haml5 = Tilt.new('views/5.haml')
slim5 = Tilt.new('views/5.slim')

# ROUND 6: + variables

class Person
  attr_reader :first_name, :last_name, :age
  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
end

# rubocop:disable Lint/UselessAssignment
person = Person.new(first_name = 'Tomek', last_name = 'Nowak', age = 30)
# rubocop:enable Lint/UselessAssignment

haml6 = Tilt.new('views/6.haml')
slim6 = Tilt.new('views/6.slim')

# ROUND 7: + actionview helpers

include ActionView::Helpers
include ActionView::RoutingUrlFor

haml7 = Tilt.new('views/7.haml')
slim7 = Tilt.new('views/7.slim')

#

title = "\n5. + RUBY FOR AND WHILE LOOPS, 2 x 1000\n#{' ' * 10}#{CAPTION}"
Benchmark.benchmark(title, 10, FORMAT) do |x|
  x.report('5haml') do
    100_000.times { haml5.render }
  end

  x.report('5slim') do
    100_000.times { slim5.render }
  end
end

title = "\n6. + VARIABLES\n#{' ' * 10}#{CAPTION}"
Benchmark.benchmark(title, 10, FORMAT) do |x|
  x.report('6haml') do
    100_000.times { haml6.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end

  x.report('6slim') do
    100_000.times { slim6.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end
end

title = "\n7. + ACTIONVIEW HELPERS\n#{' ' * 10}#{CAPTION}"
Benchmark.benchmark(title, 10, FORMAT) do |x|
  x.report('7haml') do
    100_000.times { haml7.render }
  end

  x.report('7slim') do
    100_000.times { slim7.render }
  end
end
