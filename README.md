To run this on your machine:
```bash
$ git clone https://github.com/mdkalish/haml_v_slim_benchmark
$ cd haml_v_slim_benchmark/
$ pry
[1] pry(main)> load 'haml_v_slim_benchmark.rb'
```

Here are my results obtained on [Mac Air Early 2015](http://www.everymac.com/systems/apple/macbook-air/specs/macbook-air-core-i7-2.2-13-early-2015-specs.html):

```bash
7 TESTS, 100_000 ITERATIONS FOR EACH FILE (HTML, HAML, SLIM)

1.  EMPTY FILES
                user     system      total        real
1html:       0.090000   0.000000   0.090000 (  0.088474)
1haml:       1.670000   0.020000   1.690000 (  1.693237)
1slim:       0.570000   0.000000   0.570000 (  0.574081)

2.  FILES WITH STATIC CONTENT
                user     system      total        real
2html:       0.120000   0.000000   0.120000 (  0.121111)
2haml:       1.790000   0.020000   1.810000 (  1.809351)
2slim:       0.630000   0.020000   0.650000 (  0.645870)

3.  + BOOTSTRAP CSS FROM LOCAL SSD
                user     system      total        real
3html:       0.110000   0.000000   0.110000 (  0.111630)
3haml:       1.870000   0.020000   1.890000 (  1.895476)
3slim:       0.610000   0.020000   0.630000 (  0.631458)

4.  + BOOTSTRAP JS AND JQUERY FROM LOCAL SSD
                user     system      total        real
4html:       0.140000   0.000000   0.140000 (  0.147768)
4haml:       2.070000   0.070000   2.140000 (  2.146305)
4slim:       0.870000   0.080000   0.950000 (  0.953577)

5. + RUBY FOR AND WHILE LOOPS, 2 x 1000
                user     system      total        real
5haml      284.800000   1.350000 286.150000 (290.356329)
5slim      226.340000   1.520000 227.860000 (232.264225)

6. + VARIABLES
                user     system      total        real
6haml        2.010000   0.150000   2.160000 (  2.163087)
6slim        1.770000   0.050000   1.820000 (  1.833311)

7. + ACTIONVIEW HELPERS
                user     system      total        real
7haml      318.120000   2.140000 320.260000 (321.500494)
7slim      389.790000   3.160000 392.950000 (401.462821)
```
