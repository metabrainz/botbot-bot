FROM golang:1.14-alpine as builder
WORKDIR /go/src/github.com/BotBotMe/botbot-bot

RUN apk add --no-cache git

COPY . ./
RUN go get -v . && go build -v -o botbot-bot

FROM alpine as bundle
WORKDIR /app

RUN apk add --no-cache ca-certificates

USER 1000
COPY --from=builder /go/src/github.com/BotBotMe/botbot-bot/botbot-bot .
ENTRYPOINT ["./botbot-bot", "--logtostderr"]
