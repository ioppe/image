FROM redis:4.0.1
RUN apt -y update && apt -y install wget curl gnupg gnupg2
RUN cd /usr/local && wget http://download.redis.io/releases/redis-4.0.1.tar.gz \
    && tar xvf redis-4.0.1.tar.gz
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - \
    && curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import - \
    && curl -L get.rvm.io | bash -s stable
RUN bash -c "source /usr/local/rvm/scripts/rvm \
    echo \"ruby_url=https://cache.ruby-china.com/pub/ruby\" > /usr/local/rvm/user/db \
    && rvm install 2.4.1 \
    && rvm use 2.4.1 \
    && gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ \
    && gem install redis"
