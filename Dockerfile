ARG BUILD_FROM
FROM $BUILD_FROM

# Setup base
RUN apk add --no-cache h2o openssl perl

# Copy data
COPY run.sh /
COPY h2o.conf /etc/

RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
