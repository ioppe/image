FROM redis:4.0.1
RUN apt -y update
RUN mv /etc/apt/sources.list /etc/apt/apt/source.list.bak
RUN cat > /etc/apt/sources.list <<EOF
    deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free
    # deb-src http://mirrors.ustc.edu.cn/debian stable main contrib non-free
    deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free
    # deb-src http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free

    # deb http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free
    # deb-src http://mirrors.ustc.edu.cn/debian stable-proposed-updates main contrib non-free
    EOF
RUN apt -y update
RUN apt-get -y install wget
RUN apt-get -y install curl
RUN wget wget http://download.redis.io/releases/redis-4.0.1.tar.gz
RUN tar xvf redis-4.0.1.tar.gz
RUN curl -L get.rvm.io | bash -s stable
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
RUN curl -L get.rvm.io | bash -s stable
RUN source /usr/local/rvm/scripts/rvm
RUN echo "ruby_url=https://cache.ruby-china.com/pub/ruby" > /usr/local/rvm/user/db
RUN rvm install 2.3.3
RUN rvm use 2.3.3
RUN gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
RUN gem install redis
