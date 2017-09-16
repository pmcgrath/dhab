# Builder image
ARG        ALPINE_VERSION=3.6

FROM       alpine:${ALPINE_VERSION} as builder

ARG        BUILD_DATE
ARG        REPO_BRANCH
ARG        REPO_VERSION
ARG        VERSION

COPY       * /app/
WORKDIR    /app

# Lets set the version var at the top of the script so the script is complete
RUN        sed -i "s/version=.*/version=${VERSION}/g" app.sh

# Final image
FROM       alpine:${ALPINE_VERSION}

ARG        BUILD_DATE
ARG        REPO_BRANCH
ARG        REPO_VERSION
ARG        VERSION

COPY       --from=builder /app/app.sh /

# See http://label-schema.org/rc1/
LABEL      org.label-schema.build-date=$BUILD_DATE \
           org.label-schema.schema-version="1.0" \
           org.label-schema.vcs-branch=$REPO_BRANCH \
           org.label-schema.vcs-ref=$REPO_VERSION \
           org.label-schema.version=$VERSION

ENTRYPOINT ["/app.sh"]
