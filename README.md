To run this on your machine:
```bash
$ git clone https://github.com/mdkalish/haml_v_slim_benchmark
$ cd haml_v_slim_benchmark/
$ bundle
$ pry
[1] pry(main)> load 'haml_v_slim_benchmark.rb'
```

Here are my results obtained on [Mac Air Early 2015](http://www.everymac.com/systems/apple/macbook-air/specs/macbook-air-core-i7-2.2-13-early-2015-specs.html):

```bash
4 TESTS, 100_000 ITERATIONS EACH

1. EMPTY FILES
                user     system      total        real
1html:       0.080000   0.000000   0.080000 (  0.086699)
1haml:       1.790000   0.020000   1.810000 (  1.812107)
1slim:       0.530000   0.000000   0.530000 (  0.534501)

2. FILES WITH STATIC CONTENT
                user     system      total        real
2html:       0.130000   0.010000   0.140000 (  0.135089)
2haml:       1.790000   0.010000   1.800000 (  1.816132)
2slim:       0.650000   0.020000   0.670000 (  0.671328)

3. RUBY FOR AND WHILE LOOPS, 2 x 100
                user     system      total        real
3haml       30.480000   0.190000  30.670000 ( 30.896050)
3slim       25.890000   0.230000  26.120000 ( 27.829821)

4. ACTIONVIEW HELPERS
                user     system      total        real
4haml      340.240000   3.570000 343.810000 (349.603613)
4slim      380.680000   2.870000 383.550000 (388.684576)

5. VARIABLES
                user     system      total        real
5haml        1.640000   0.010000   1.650000 (  1.654494)
5slim        1.580000   0.010000   1.590000 (  1.585720)
```

### Caveats:

- Limited scope:
  ```bash
  $ ruby -v
  ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin14]
  ```
- Template rendering is not a bottleneck anyways: after the first render,
  contents will be loaded from cache as ready htmls.
  Fragment caching is not accounted for in this benchmark.
