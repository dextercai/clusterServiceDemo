NAME=clusterServiceDemo
BINDIR=/build
GOBUILD=CGO_ENABLED=0 go build -trimpath

all: build # Most used

build:
	$(GOBUILD) -o $(BINDIR)/$(NAME) ./cmd/api/api.go