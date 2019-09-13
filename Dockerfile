FROM debian:buster-slim AS build
RUN apt-get update -y
RUN apt-get install -y gcc g++ libz-dev ncurses-dev libc-dev curl make
WORKDIR /build
RUN curl -OL https://github.com/ding-lab/msisensor/archive/0.6.tar.gz
RUN tar xzf 0.6.tar.gz
WORKDIR /build/msisensor-0.6
RUN make

FROM debian:buster-slim
RUN apt-get update -y && \
    apt-get install -y libgomp1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /build/msisensor-0.6/msisensor /usr/local/bin/msisensor
