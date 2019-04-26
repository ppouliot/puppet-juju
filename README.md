# puppet-juju

A puppet module for deploying and managing [Juju](https://jujucharms.com)

(This is unaffiliated with [Juju](https://jujucharms.com) or [Canonical](http://canonical.com) )


![Juju](https://assets.ubuntu.com/v1/31c507a5-logo-juju-icon.svg)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with juju](#setup)
    * [What juju affects](#what-juju-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with juju](#beginning-with-juju)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This Puppet module deploys the JUJU packages and provides puppetized
Administration of the JUJU deployment

## Module Description
This Puppet module deploys the JUJU packages and provides puppetized

## Setup


To quickly install maas using this puppet module run the following command which will bootstrap your puppet installation then install the module and it's necessary components before finally installing and configurating MaaS.

```
wget https://raw.githubusercontent.com/ppouliot/puppet-juju/master/files/bootstrap_puppet_to_juju.sh -O - | sh
```

Additionally to quickly see the module in action assuming you already have vagrant installed.

```
git clone https://github.com/ppouliot/puppet-juju
cd puppet-juju && vagrant up
```

### What juju affects

* Packages
  * juju
* Users
  * juju
* Services
  * tbd
* FIles
  * tbd

### Setup Requirements 

* Ubuntu 14.04
* Ubuntu 16.04
* Ubuntu 18.04


### Beginning with juju

The very basic steps needed for a user to get the module up and running.
include juju
If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For documentation on JUJU, see https://juju.ubuntu.com/docs).

## Basic Usage

  ```
  class{'juju':}

  ```
## Usage: Include Juju-Jitsu Packages
  
  ```
  class{'juju':
    juju_jitsu => true,
  }
  ```

## Reference

### Classes
* `juju`: Main Class
* `juju::params`: Sets the defaults for the juju module parameters
* `juju::install`: Installs the JUJU package
* `juju::config`: A placeholder class for processing

## Limitations

* Ubuntu platforms only, specifcally 14.04, 16.04 and 18.04.

## Development

Feel free to open pull requests or issues at [https://github.com/ppouliot/puppet-juju](https://github.com/ppouliot/puppet-juju)

## Contributors
* Peter Pouliot <peter@pouliot.net>

## Copyright and License

Copyright (C) 2015 Peter J. Pouliot

Peter Pouliot can be contacted at: peter@pouliot.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
