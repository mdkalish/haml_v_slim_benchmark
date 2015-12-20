To run this on your machine:
```bash
$ git clone https://github.com/mdkalish/haml_v_slim_benchmark
$ cd haml_v_slim_benchmark/
$ bundle
$ ./run.sh
```

Here are my results obtained on [Mac Air Early 2015](http://www.everymac.com/systems/apple/macbook-air/specs/macbook-air-core-i7-2.2-13-early-2015-specs.html):

```bash
5 TESTS, 100_000 ITERATIONS EACH

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

### Caveats to the benchmark:

- Limited scope:
```bash
$ ruby -v
ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin14]
```
- Template rendering is most often not a bottleneck anyways: after the first render,
  contents will be loaded from cache as ready htmls.
  Fragment caching is not accounted for in this benchmark.


### BREAKDOWN

- Slim is **much** faster
- Slim is **much** cleaner
- Slim supports HTML streaming, HAML doesn't
- Haml would be Slim if it were well-written, but it isn't
- Using Haml can be rationalised only by a habit. It has been around for a longer time than Slim and this is the only reason it is still in use.

#### Why is everybody not switching to Slim?

- No one cares about promoting Slim. [The author wrote it for his own use]  (https://github.com/slim-template/slim/issues/386#issuecomment-16690419).
- Haml has been around for a much longer time and programmers are very conservative people. In general we have much trouble with accepting new things, no matter if better or worse. ([From Crockford](https://www.youtube.com/watch?v=JxAXlJEmNMg))

#### Conclusion:

Use Haml if:
  - don't use Haml
  - it has nothing to trump Slim but the length of service

Use Slim if:
  - you want lightning-fast parsing (almost as fast as ERB, up to 9 times faster than Haml)
  - you care about readibility and aesthetics

Further reading:
- [Very extensive, comprehensive, and detailed benchmark](https://sephinrothcn.wordpress.com/2014/04/14/slim-vs-haml-performance-perspective/). The bottom line is Slim is maybe the best and Haml is definitely the worst.
- There is [Hamlit gem](https://github.com/k0kubun/hamlit) which is an attempt to _slim the Haml_, said to be almost 9 times faster than Haml, thus also faster than Erb and Slim, but it's a young project (started in March 2015) **with limitations**.
