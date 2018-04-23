.PHONY: compile update clean deep-clean

all: compile

DOCKER_BUILD := docker build
REGISTRY := vdasari

grpc-full:
	$(DOCKER_BUILD) -t $(REGISTRY)/grpc -f grpc/Dockerfile grpc

grpc-alpine:
	$(DOCKER_BUILD) -t $(REGISTRY)/grpc:alpine -f grpc/alpine.Dockerfile grpc

gobgp-full:
	$(DOCKER_BUILD) -t $(REGISTRY)/gobgp -f gobgp/Dockerfile gobgp

gobgp-alpine:
	$(DOCKER_BUILD) -t $(REGISTRY)/gobgp:alpine -f gobgp/alpine.Dockerfile gobgp

erlango-alpine:
	$(DOCKER_BUILD) -t $(REGISTRY)/erlango:alpine -f erlango/alpine.Dockerfile erlango

erlango-full:
	$(DOCKER_BUILD) -t $(REGISTRY)/erlango:latest -f erlango/Dockerfile erlango

alpine-dev:
	echo $(DOCKER_BUILD) -t $(REGISTRY)/alpine-dev:latest -f alpine/Dockerfile alpine
	$(DOCKER_BUILD) -t $(REGISTRY)/alpine-dev:latest -f alpine/Dockerfile alpine

ryu:
	$(DOCKER_BUILD) -t $(REGISTRY)/ovs-mn-ryu:latest -f ovs-mn-ryu/Dockerfile ovs-mn-ryu

erl17-full:
	$(DOCKER_BUILD) -t $(REGISTRY)/erl17:latest -f erl17/Dockerfile erl17

.SILENT:
