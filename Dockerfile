FROM ruby:2.2.2

# `rails/execjs` изисква Node.js
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y nodejs && rm -rf /var/lib/apt/lists/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
