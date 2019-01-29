# https://gist.github.com/krsna1729/c4862f278e74b337177937b6e70cc4a2
FROM krsna1729/bess
RUN pip install --no-cache-dir pyroute2
CMD bessd -f
