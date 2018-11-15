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
    && ln -s data/hiera.yaml /etc/puppetlabs/hiera.yaml \
    && cp data/juju.yaml data/nodes/`facter | grep fqdn | awk '{print $3}'| sed -e 's/\"//g'| awk -F. '{print $1}'`.yaml \
    && ls data/nodes && echo $HOSTNAME \
    && puppet module list \
    && puppet module list --tree 
RUN puppet apply --debug --trace --verbose --modulepath=/etc/puppetlabs/code/environments/production/modules /etc/puppetlabs/code/environments/production/modules/juju/tests/init.pp
EXPOSE 80
