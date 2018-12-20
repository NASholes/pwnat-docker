FROM debian:stable-slim as build

RUN apt-get update -y
RUN apt-get install -y curl build-essential

RUN mkdir /build
WORKDIR /build

RUN curl -sSLf https://samy.pl/pwnat/pwnat-0.3-beta.tgz -o /build/pwnat-0.3-beta.tgz  \
    && tar -xf /build/pwnat-0.3-beta.tgz \
    && cd /build/pwnat-0.3-beta \
    && make

FROM debian:stable-slim

ENTRYPOINT ["pwnat"]
CMD ["-h"]

COPY --from=build /build/pwnat-0.3-beta/pwnat /usr/local/bin/pwnat
