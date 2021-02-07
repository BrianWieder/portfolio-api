FROM golang:1.14.15-alpine AS builder

WORKDIR /tmp/go-app

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 go test -v

RUN go build -o ./out/portfolio-api

FROM alpine

COPY --from=builder /tmp/go-app/out/portfolio-api /app/portfolio-api

EXPOSE 80

CMD ["/app/portfolio-api"]