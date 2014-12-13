############################################################
# Dockerfile to install Go 1.4
# Based on RHEL7.0 Image
############################################################

FROM localhost:5000/cepro/go:1.4

RUN echo $'package main\nimport (\n\t"github.com/mathcunha/amon"\n\t"os"\n)\n\nfunc main(){\n\tamon.Monitor(os.Getenv("AMON_FILE"))\n}' > /usr/local/main.go
ENV GOROOT /go
RUN export PATH=$PATH:/usr/local/go/bin:$GOROOT/bin

RUN go get http://github.com/mathcunha/amon

ENTRYPOINT ["go run /usr/local/main.go"]

# Set the file maintainer (your name - the file's author)
MAINTAINER Matheus Cunha
