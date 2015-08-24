# juju

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

### What juju affects

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

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

* Ubuntu 14.04

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Changelog

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.

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
