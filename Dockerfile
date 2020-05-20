FROM ruby:2.6.4

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --system

ADD . /app
RUN bundle install --system

EXPOSE 3000

CMD ["puma", "config.ru", "-C", "puma.rb"]