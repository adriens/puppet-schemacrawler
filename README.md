# schemacrawler

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with schemacrawler](#setup)
    * [What schemacrawler affects](#what-schemacrawler-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with schemacrawler](#beginning-with-schemacrawler)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Module that installs [schemacrawler](http://sualeh.github.io/SchemaCrawler/) on 'nix like systems.


## Module Description

This module :

1. Download (by staging) the zip from [schemacrawler github releases page](https://github.com/sualeh/SchemaCrawler/releases/)
3. Unzip in the proper directory (```/opt/apps/schemacrawler/```) and create symlinks so schemcrawler is
immediatley in ```PATH```

You may want to use this module if you want to install schemacrawler in a convenient way.

For now, the only purpose of this module is to install schemacrawler.

## Setup

### Requirements

* Puppet node must have web access to download the zip from github
* Have at least Java 1.8 as [SchemaCrawler works with Java SE 8 and above](http://sualeh.github.io/SchemaCrawler/faq.html#supported-java), and set to alternatives.


### What schemacrawler affects

This module creates the following directories :

* ```/opt/staging/schemacrawler/```
* ```/opt/apps/schemacrawler/```
* symbolic link ```/usr/bin/schemacrawler```
* symbolic link ```/opt/schemacrawler```

This module adds (if not present) the ```graphviz``` package) so schemacrawler will be able to draw relationships graphs.

**Notice that this module WILL NOT install any Java runtime. You'll have to do this your way.**

### Setup Requirements

Java 1.8 (at least) **must** be installed, and ```java``` in the ```PATH```.

### Beginning with schemacrawler

To use this module, simply add this code in your manifest :

	class {'schemacrawler::install':
	}

## Usage

To use this module, simply add this code in your manifest : this module, simply add this code in your manifest :

        class {'schemacrawler::install':
        }

If you are behind a corporate proxy, use the following code :

        class {'schemacrawler::install':
        environment => 'http_proxy="http://scott:tiger@myproxy:3128"'}


## Limitations

For now, this module **does not* work on Windows systems.

## Development

I'm a true beginner on puppet, so feel free to contribute to the project by creating PR that make
the module better. You are welcome to donate code, or simply say thank you ;-p

## Release Notes

This the first release, for now it installs schemacrawler.

## TODO

* Make staging and install dir as parameters.

