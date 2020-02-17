FROM ruby:2.6.3-alpine

RUN apk add --update --no-cache bash build-base tzdata postgresql-dev

RUN gem install bundler:2.1.4

WORKDIR /opt/app/

COPY Gemfile* /opt/app/

RUN bundle install

COPY . /opt/app/

ENV PATH=./bin:$PATH

RUN chmod +x ./docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["sh", "./docker-entrypoint.sh"]
