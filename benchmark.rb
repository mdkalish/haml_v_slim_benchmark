require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'

for i in 1..4 do # rubocop:disable Style/For
  # ROUND 1: empty files
  # ROUND 2: files with static content
  # ROUND 3: + bootstrap css from local ssd
  # ROUND 4: + bootstrap js and jquery from local ssd

  html = Tilt.new("#{i}.html")
  haml = Tilt.new("#{i}.haml")
  slim = Tilt.new("#{i}.slim")

  Benchmark.bm do |x|
    x.report('html') do
      100_000.times { html.render }
    end

    x.report('haml') do
      100_000.times { haml.render }
    end

    x.report('slim') do
      100_000.times { slim.render }
    end
  end
end

# ROUND 1: empty files

#        user     system      total        real
# haml  1.480000   0.010000   1.490000 (  1.492731)
# slim  0.520000   0.000000   0.520000 (  0.521339)

# ROUND 2: files with static content

#        user     system      total        real
# haml  1.590000   0.020000   1.610000 (  1.617116)
# slim  0.590000   0.020000   0.610000 (  0.606256)

# ROUND 3: + bootstrap css from local ssd

#        user     system      total        real
# haml  1.620000   0.020000   1.640000 (  1.649548)
# slim  0.620000   0.020000   0.640000 (  0.643123)

# ROUND 4: + bootstrap js and jquery from local ssd

#        user     system      total        real
# haml  1.780000   0.100000   1.880000 (  1.888760)
# slim  0.770000   0.080000   0.850000 (  0.854597)

# ROUND 5: + ruby for and while loops, 2 x 1000

require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'

haml = Tilt.new('5.haml')
slim = Tilt.new('5.slim')

Benchmark.bm do |x|
  x.report('haml') do
    100_000.times { haml.render }
  end

  x.report('slim') do
    100_000.times { slim.render }
  end
end

#        user     system      total        real
# haml323.400000   1.220000 324.620000 (326.242959)
# slim223.920000   0.720000 224.640000 (226.115435)

# ROUND 6: + variables

require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'

class Person
  attr_reader :first_name, :last_name
  def initialize(first_name, last_name, age)
    @first_name = first_name
    @last_name = last_name
    @age = age
  end
end

person = Person.new(first_name: 'Tomek', last_name: 'Nowak')

haml = Tilt.new('6.haml')
slim = Tilt.new('6.slim')

Benchmark.bm do |x|
  x.report('haml') do
    100_000.times { haml.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end

  x.report('slim') do
    100_000.times { slim.render(person, first_name: 'Tomek', last_name: 'Kowal', age: 30) }
  end
end

#         user     system      total        real
# haml  2.060000   0.210000   2.270000 (  2.295099)
# slim  1.730000   0.050000   1.780000 (  1.786704)

# ROUND 7: + actionview helpers

require 'haml'
require 'slim'
require 'tilt'
require 'benchmark'
require_relative '/Users/Maciej/.rvm/gems/ruby-2.2.3/gems/actionview-4.2.4/lib/action_view.rb'
include ActionView::Helpers
include ActionView::RoutingUrlFor

thaml = Tilt.new('5.haml')
tslim = Tilt.new('5.slim')

Benchmark.bm do |x|
  x.report('haml') do
    100_000.times { thaml.render }
  end

  x.report('slim') do
    100_000.times { tslim.render }
  end
end

#        user     system      total        real
# haml 334.640000   2.530000 337.170000 (341.637907)
# slim 379.270000   1.930000 381.200000 (382.527633)
