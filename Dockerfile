# program assembly
FROM alpine AS build

# install the necessary packages for assembly
RUN apk add --no-cache build-base make automake autoconf git pkgconfig glib-dev gtest-dev gtest cmake

# copy from my github repo
WORKDIR /home/optima
RUN git clone --branch branchHTTPserver https://github.com/rovniy0/devops-3.git
WORKDIR /home/optima/devops-3

# install env and conf program
RUN autoconf
RUN ./configure
RUN cmake

# add entrypoint 
FROM alpine
RUN apk add --no-cache libstdc++ libc6-compat
COPY --from=build /home/optima/devops-3/myprogram /usr/local/bin/myprogram
ENTRYPOINT ["/usr/local/bin/myprogram"]


