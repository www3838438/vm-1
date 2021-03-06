#!/bin/sh

# Pretty print messages
print_header() {
    length=${#1}
    line=`printf '%*s' $length | tr ' ' "="`
    echo -e '\n'$line
    echo -e $1
    echo -e "$line\n"
}

print_header "updating ubuntu"
#Add repositories for QGIS, Atom, Sublime Text 3 and Tor Browser bundle
echo "deb http://qgis.org/debian xenial main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://qgis.org/debian xenial main" | sudo tee -a /etc/apt/sources.list
#add gpg key for qgis download and install
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 073D307A618E5811

sudo add-apt-repository -y ppa:webupd8team/atom
# sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:webupd8team/tor-browser



#Update apt-get and upgrade packages
sudo apt-get -qq update
sudo apt-get -qq upgrade

# development
print_header "installing development tools"
sudo apt-get -qq install build-essential fortune cowsay

# Git
print_header "installing git"
sudo apt-get -qq install git-core

# zsh
# print_header "installing zsh and oh-my-zsh"
# wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# python scientific stack
print_header "installing python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib ipython ipython-doc ipython-notebook ipython-qtconsole python-virtualenv python-dev python-pip python-sip pyqt4-dev-tools

# various Python libraries we like
print_header "pip installing favored Python libraries"
sudo pip install --quiet beautifulsoup4
sudo pip install --quiet requests
sudo pip install --quiet django
sudo pip install --quiet virtualenvwrapper
sudo pip install --quiet pandas
sudo pip install --quiet csvkit
sudo pip install --quiet miditime
sudo pip install --quiet flask
sudo pip install --quiet agate

# make sure virtalenvwrapper is loaded and works
print_header "  setting up virtualenvwrapper"
mkdir .envs
echo "export WORKON_HOME=$HOME/.envs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc

echo "export WORKON_HOME=$HOME/.envs" >> ~/.zshrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.zshrc

# postgres
print_header "installing latest PostgreSQL and PostGIS"
sudo apt-get install -qq postgresql
sudo apt-get install -qq postgis

echo "  IMPORTANT: Remember to create a Postgres superuser for your user!"

# MySQL
print_header "Installing MySQL"
sudo apt-get -qq install mysql-server mysql-client libmysqlclient-dev

#qgis
print_header "installing QGIS"

sudo apt-get install -y qgis python-qgis

#pspp
print_header "installing PSPP"
sudo apt-get install pspp

# node.js
print_header "installing Node.js"
sudo apt-get -qq install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node

#npm
sudo apt-get install -y npm

#Atom text editor
print_header "installing Atom text editor"
sudo apt-get install -y atom

#Sublime text 3
# print_header "installing Sublime Text 3"
# sudo apt-get install sublime-text-installer

#Tor Browser
sudo apt-get install tor-browser

#install Java
print_header "installing Java"
sudo apt-get -qq install default-jre

#install ILENE
git clone https://github.com/thejefflarson/ILENE
cd ILENE
npm install
cd

# Install Ruby
print_header "installing Ruby, rbenv and ruby-build"

#install dependencies
sudo apt-get install -qq autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

#install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc

#install ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.bashrc
# source ~/.zshrc

#install latest stable version of Ruby
rbenv install 2.2.0
rbenv global 2.2.0


#install jruby
# print_header "installing jruby for Tabula"
# rbenv install jruby-1.7.18
# #install Tabula extractor for awesome command line pdf extraction
# echo " Setting up Tabula"
# mkdir tabula
# cd tabula
# rbenv local jruby-1.7.18
# jruby -S gem install tabula-extractor
# cd # return home

#perform one last upgrade to all software packages
sudo apt-get upgrade

# randomly generate animal
# animals=$(cowsay -l | tail -n+2 | shuf)
# test=" " read -a array <<< "$animals"

# # cowsay
# cowsay -f ${array[2]} "All done! Now, go save journalism!"
cowsay "All done! Now, go save journalism!"
