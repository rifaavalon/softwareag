#!/bin/bash

sudo yum -y update
sudo yum -y install nginx git curl

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

\curl -L https://get.rvm.io | bash -s stable
rvm requirements
rvm install 2.4
gem install bundler --no-ri --no-rdoc


git clone https://github.com/rifaavalon/pingruby.git

cd pingruby

ruby ping.rb 
