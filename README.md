# Ruby version

* ruby 2.4.5
* bundler 1.17.1

# Install sample (Ubuntu)

```
sudo apt update
sudo apt upgrade
sudo apt install -y build-essential
sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev
sudo apt-get install -y nodejs

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

source ~/.bash_profile
rbenv --version

rbenv install --list
rbenv install 2.4.5
rbenv versions
rbenv global 2.4.5

gem install bundler -v 1.17.1

git clone https://github.com/yuknak/antenna.git

cd antenna

bundle install --path vendor/bundle

bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rails server -b 0.0.0.0 -p 3000 -d

sudo service cron start

bundle exec whenever -i
```
