FROM ruby:2.6.5-alpine

# Build-time metadata as defined at http://label-schema.org

RUN apk add --no-cache  build-base \
                        postgresql-dev \
                        tzdata \
                        nodejs \
                        yarn \
                        vips-dev \
                        git

ENV LANG=C.UTF-8 \
    APP_HOME=/it52 \
    EDITOR=vi \
    MALLOC_ARENA_MAX=2 \
    RAILS_LOG_TO_STDOUT=true \
    BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=6 \
    BUNDLE_RETRY=3

ENV HISTFILE=$APP_HOME/log/.bash_history \
    PSQL_HISTFILE=$APP_HOME/log/.psql_history \
    IRB_HISTFILE=$APP_HOME/log/.irb_history \
    PRY_HISTFILE=$APP_HOME/log/.pry_history \
    PATH=$APP_HOME/bin:$BUNDLE_PATH/bin:$PATH


# Install latest rubygems, bundler and rake
RUN mkdir $BUNDLE_PATH

RUN gem update --system && gem install bundler rake pry

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN bundle install

COPY package.json yarn.lock $APP_HOME/
RUN yarn install && yarn cache clean

ADD . $APP_HOME

EXPOSE 3000

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="IT52" \
      org.label-schema.description="IT52 rails application" \
      org.label-schema.url="https://www.it52.info" \
      org.label-schema.maintainer="Nick Kugaevsky \"nick@kugaevsky.ru\"" \
      org.label-schema.usage="README.md" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/nnrug/it52-rails" \
      org.label-schema.vendor="IT52" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

CMD ["bundle", "exec", "rails", "console"]
