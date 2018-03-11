
# Spark Clients

There are various different options involved when working with
interactive pyspark environments.

## Python Interpreter

This is the default we've been using from class

```bash
docker-compose exec spark pyspark
```

We're learning on this one because it's the most likely to be available over a
wide range of spark installation/configuration options.

You can tell the plain python interpreter to save the interpreter history
(inputs only) by evaluating the following in the interpreter

```python
import readline
readline.write_history_file('/w205/history')
```

There're ways to have this automatically run when you start up the interpreter,
but your needs may vary.


## iPython Interpreter

You can enable that by replacing the std `docker-compose exec
spark pyspark` with

```bash
docker-compose exec spark env PYSPARK_DRIVER_PYTHON=ipython pyspark
```

So `ipython` has history tracking on by default and it writes to `/w205` within
the container.  


## Jupyter Notebook

A notebook provides us with a lot of options

```bash
docker-compose exec spark env PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root' pyspark
```

This is really cool, but requires more port finagling than the other options.
