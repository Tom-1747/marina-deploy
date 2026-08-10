FROM ocaml/opam:alpine-ocaml-5.2 AS deps

WORKDIR /home/opam/app

RUN sudo apk add --no-cache m4

RUN opam install -y -j4 --no-depexts ocamlfind ounit2

FROM ocaml/opam:alpine-ocaml-5.2 AS build

WORKDIR /home/opam/app

COPY --from=deps /home/opam/.opam /home/opam/.opam

RUN sudo apk add --no-cache m4

COPY --chown=opam:opam . .

RUN opam exec -- make

FROM alpine:3.20 AS runtime

WORKDIR /app

RUN apk add --no-cache libstdc++

COPY --from=build /home/opam/app/marina .

CMD ["./marina"]