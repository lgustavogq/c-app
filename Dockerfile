FROM gcc:latest as builder
WORKDIR /usr/src/app
COPY main.c .
RUN gcc -static -o myapp main.c

FROM alpine:latest
WORKDIR /app
COPY --from=builder /usr/src/app/myapp .
CMD ["./myapp"]
