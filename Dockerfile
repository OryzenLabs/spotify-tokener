FROM --platform=$BUILDPLATFORM golang:1.25-alpine AS build

WORKDIR /app

# Cache deps
COPY go.mod go.sum ./
RUN go mod download

# Copy source
COPY . .

# Build binary
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 \
    GOOS=$TARGETOS \
    GOARCH=$TARGETARCH \
    go build -o spotokn ./cmd/spotokn


FROM chromedp/headless-shell

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENV BROWSER_BIN=/headless-shell/headless-shell
ENV PORT=8080
ENV HEADLESS=true

COPY --from=build /app/spotokn /usr/local/bin/spotokn

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/spotokn"]
