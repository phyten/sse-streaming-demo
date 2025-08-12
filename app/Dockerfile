FROM ruby:3.4.4-alpine

RUN apk add --no-cache build-base curl linux-headers

WORKDIR /app

COPY Gemfile* ./
RUN bundle config set deployment 'true' \
 && bundle config set without 'development test' \
 && bundle install

COPY . .

EXPOSE 9292

CMD ["bundle", "exec", "rerun", "--background", "ruby app.rb"]
