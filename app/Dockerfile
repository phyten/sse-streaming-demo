FROM ruby:3.4.4-alpine

RUN apk add --no-cache build-base curl

WORKDIR /app

COPY Gemfile* ./
RUN bundle config set deployment 'true' \
 && bundle config set without 'development test' \
 && bundle install

COPY . .

ENV RACK_ENV=production
EXPOSE 9292

# For development with volume mounts
RUN gem install rerun

CMD ["bundle", "exec", "rerun", "--background", "ruby app.rb"]
