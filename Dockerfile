FROM golang:1.10-alpine as builder
WORKDIR /go/src/github.com/BotBotMe/botbot-bot

RUN apk add --no-cache git

COPY . ./
RUN go get -v . && go build -v -o botbot-bot

FROM alpine as bundle
WORKDIR /app

RUN apk add --no-cache ca-certificates

RUN addgroup -S app && adduser -S -G app app
USER app

COPY --from=builder /go/src/github.com/BotBotMe/botbot-bot/botbot-bot .
ENTRYPOINT ["./botbot-bot", "--logtostderr=1", "--stderrthreshold=0", "--v=2"]
