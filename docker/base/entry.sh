#!/bin/bash

exec /usr/local/bin/jupyter-notebook \
  --NotebookApp.token=${TOKEN:-Default1ClickToken} \
  --no-browser \
  --port 8888 \
  --ip=0.0.0.0 \
  --allow-root
