# pp-podman_schedtask
Puppet code that executes podman container job based on schedule

# for rhel 8 container
<!-- docker run -dt --name rhel8-monitoring redhat/ubi8 -->
docker run -dt --name rhel8-monitoring redhat/ubi8-init

dnf install -y git

git clone git@github.com:jajera/pp-podman_schedtask.git

sh ./build

/opt/puppetlabs/bin/puppet apply . --hiera_config hiera.yaml


######################################
# for rhel8 vm

apply using terraform

sudo dnf install -y git

git clone https://github.com/jajera/pp-podman_schedtask.git

cd pp-podman_schedtask/

git checkout dev

sudo sh ./build.sh

sudo /opt/puppetlabs/bin/puppet apply . --hiera_config hiera.yaml



######################################
# testing with bundler

gem install bundler --no-document

echo "source 'https://rubygems.org'" > Gemfile
echo "gem 'rspec-puppet'" >> Gemfile

bundle install

mkdir -p spec/classes

touch spec/classes/init_spec.rb

bundle exec rspec .


######################################
# testing with pdk

pdk validate --parallel
pdk test unit
pdk convert
pdk bundle install
gem install puppet-lint --no-document