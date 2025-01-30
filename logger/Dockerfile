# want to use a minimal image, that runs ruby
FROM ruby:3.1.2-slim

# installing
# - iputils-ping to be able to ping the internet
# - sqlite3 database, and the development libraries libsqlite3-dev
# - cron to run the ruby script periodically, and save the disconnections data
RUN apt-get update && apt-get install -y iputils-ping sqlite3 libsqlite3-dev cron

# Copy the crontab
COPY logger-cron /etc/cron.d/logger-cron
RUN chmod 0644 /etc/cron.d/logger-cron && crontab -u root /etc/cron.d/logger-cron

# set the working directory in the image
WORKDIR /app

# should copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# run bundle install to install the gems
RUN bundle install

# copy the rest of the application into the image
COPY *.rb ./

# copy the ping logger script into the image
COPY connection_check_with_timestampt.sh setup.sh ./
RUN chmod +x ./connection_check_with_timestampt.sh ./setup.sh

# we run the ping logger, and write the output to a file, and tail
CMD ["./setup.sh"]
