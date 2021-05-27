FROM golang:1.11-alpine as builder

WORKDIR /go/src/github.com/gavinmcnair/hello-simon

RUN apk add --update --no-cache alpine-sdk

COPY . .

RUN make

FROM scratch
MAINTAINER Gavin McNair <gavinmcnair@gmail.com>

ARG git_repository="Unknown"
ARG git_commit="Unknown"
ARG git_branch="Unknown"
ARG built_on="Unknown"

LABEL git.repository=$git_repository
LABEL git.commit=$git_commit
LABEL git.branch=$git_branch
LABEL build.on=$built_on

COPY --from=builder /go/src/github.com/gavinmcnair/hello-simon/bin/hello-simon .

CMD [ "/hello-simon" ]
