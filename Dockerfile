FROM golang:1.16.5 as builder
WORKDIR /go/src/app
COPY . .
RUN go get -d -v ./...
RUN CGO_ENABLED=0 GOOS=linux go build -v -o app

FROM gcr.io/distroless/base
COPY --from=builder /go/src/app/app /app
CMD ["/app"]
