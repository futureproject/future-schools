SITE="http://tfp-principals.herokuapp.com/"
TRIALS=10000
CONCURRENCY=200
ab -n $TRIALS -c $CONCURRENCY $SITE
