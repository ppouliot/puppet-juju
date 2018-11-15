FROM puppet/puppet-agent
MAINTAINER peter@pouliot.net
RUN mkdir -p /etc/puppetlabs/code/modules/juju
COPY . /etc/puppetlabs/code/modules/juju
COPY Puppetfile /etc/puppetlabs/code/environments/production/Puppetfile
COPY Dockerfile Dockerfile
COPY VERSION VERSION
RUN \
    apt-get update -y && apt-get install git software-properties-common -y \
    && gem install r10k \
    && cd /etc/puppetlabs/code/environments/production/ \
    && r10k puppetfile install --verbose DEBUG2 \
    && puppet module list \
    && puppet module list --tree 
RUN puppet apply --debug --trace --verbose --modulepath=/etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/modules/juju/tests/init.pp
EXPOSE 80
