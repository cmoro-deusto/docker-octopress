FROM ubuntu:14.04
MAINTAINER Xabier Larrakoetxea <slok69@gmail.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y ruby ruby-dev git build-essential python

# Set correct local
RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_GB.UTF-8

# Create editor userspace
RUN groupadd octopress
RUN useradd octopress -m -g octopress -s /bin/bash
RUN passwd -d -u octopress
RUN echo "octopress ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/octopress
RUN chmod 0440 /etc/sudoers.d/octopress
RUN mkdir /home/octopress/Code
RUN chown octopress:octopress /home/octopress/Code

# Set octopress
RUN gem install bundler
USER octopress
WORKDIR /tmp
RUN rm -rf /tmp/octopress
# Use vagrant user for the upcoming tasks
CMD ["/bin/bash"]

VOLUME "/home/octopress/Code"
EXPOSE 4000
WORKDIR /home/octopress/Code
