BIN = forego
GOFILES = $(shell find . -name '*.go' -not -path './vendor/*')
GOPACKAGES = $(shell go list ./...  | grep -v /vendor/)

.PHONY: all build clean lint release test

all: build

build: $(BIN)

clean:
	rm -f $(BIN)

lint: $(GOFILES)
	go fmt

release:
	bin/release

test: lint build
	@go test -v -race -cover $(GOPACKAGES)

$(BIN): $(GOFILES)
	go build -o $@