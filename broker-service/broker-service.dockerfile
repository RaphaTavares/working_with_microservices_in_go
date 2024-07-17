# base go image
FROM golang:1.22.4-alpine as builder

# cria a pasta lá na instancia
RUN mkdir /app

# copia daqui de onde ta a dockerfile lá pra dentro da instância
COPY . /app

# setta o working directory lá na instancia
WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# n é certeza de precisar, mas add a flag executable
RUN chmod +x /app/brokerApp


# build a tiny docker image
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD [ "/app/brokerApp" ]