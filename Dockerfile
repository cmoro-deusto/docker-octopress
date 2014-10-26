FROM ubuntu:14.04
MAINTAINER Carlos Moro (kudos to slok) <cmoro@deusto.es>

# Set locales
RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_GB.UTF-8

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Create editor userspace
RUN groupadd octopress
RUN useradd octopress -m -g octopress -s /bin/bash
RUN passwd -d -u octopress
RUN echo "octopress ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/octopress
RUN chmod 0440 /etc/sudoers.d/octopress
RUN mkdir /home/octopress/Code
RUN chown octopress:octopress /home/octopress/Code

# Install dependencies
RUN apt-get update
RUN apt-get install -y ruby ruby-dev git build-essential curl nodejs
RUN gem install bundler

# Install octopress
USER octopress
WORKDIR /tmp
RUN git clone git://github.com/imathis/octopress.git octopress
WORKDIR /tmp/octopress
RUN bundle install
#RUN rake install
RUN rm -rf /tmp/octopress

# Use vagrant user for the upcoming tasks
CMD ["/bin/bash"]
VOLUME "/home/octopress/Code"
EXPOSE 4000
WORKDIR /home/octopress/Code
