FROM ruby:2.2.2

# `rails/execjs` изисква Node.js
RUN cd /tmp && \
    wget https://nodejs.org/dist/v16.20.0/node-v16.20.0-linux-x64.tar.xz && \
    tar -xJf node-v16.20.0-linux-x64.tar.xz && \
    mv node-v16.20.0-linux-x64/bin/* /usr/bin && \
    mv node-v16.20.0-linux-x64/include/* /usr/include && \
    mv node-v16.20.0-linux-x64/lib/* /usr/lib && \
    mv node-v16.20.0-linux-x64/share/doc/* /usr/share/doc && \
    mv node-v16.20.0-linux-x64/share/man/man1/* /usr/share/man/man1 && \
    mv node-v16.20.0-linux-x64/share/systemtap/* /usr/share/systemtap && \
    rm -rf node-v16.20.0-linux-x64  node-v16.20.0-linux-x64.tar.xz

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
