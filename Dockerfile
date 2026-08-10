FROM ocaml/opam:debian-12-ocaml-4.14

WORKDIR /app

COPY . .

RUN make

FROM debian:12-slim

WORKDIR /app

COPY --from=0 /app/marina /app/marina

ENTRYPOINT ["./marina"]