# puppet module corp104_prerender
[![Build Status](https://travis-ci.com/104corp/puppet-corp104_prerender.svg?branch=master)](https://travis-ci.com/104corp/puppet-corp104_prerender)


#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with corp104_prerender](#setup)
    * [Beginning with corp104_prerender](#beginning-with-corp104_prerender)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The corp104_prerender module installs, configures, and manages the corp104_prerender service across a range of operating systems and distributions.

## Setup

### Beginning with corp104_prerender

`include '::corp104_prerender'` is enough to get you up and running.

## Usage

All parameters for the ntp module are contained within the main `::corp104_prerender` class, so for any function of the module, set the options you want. See the common usages below for examples.

### Install and enable corp104_prerender

```puppet
include '::corp104_prerender'
```

### Install specially prerender version for package ensure.'

```puppet
class { 'corp104_prerender': }
```

## Reference

### Classes

#### Public classes

* corp104_prerender: Main class, includes all other classes.

#### Private classes

* corp104_prerender::install Handles the packages.
* corp104_prerender::config Handles the node packages.
* corp104_prerender::service Handles the config.


## Limitations

This module cannot guarantee installation of corp104_prerender versions that are not available on  platform repositories.

This module is officially [supported](https://forge.puppetlabs.com/supported) for the following Java versions and platforms:

## Development

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great. Please follow our guidelines when contributing changes.

For more information, see our [module contribution guide.](https://docs.puppetlabs.com/forge/contributing.html)

### Contributors

To see who's already involved, see the [list of contributors.](https://github.com/puppetlabs/puppetlabs-ntp/graphs/contributors)
