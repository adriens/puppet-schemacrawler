# == Class: schemacrawler
#
# Schemacrawler installation class.
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
#   Schemacrawler version ou want to install.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class {'schemacrawler::install':
#  }
#
# === Authors
#
# Adrien Sales <Adrien.Sales@gmail.com>
#
# === Copyright
#
# Copyright 2015 Adrien Sales.
#
class schemacrawler::install($version = '14.03.03',
                             $environment = undef) {

if $java_major_version < '8' {
  fail("Unsatisfied java version : detected <${java_version}>, expected at least 1.8.")
}
# Setup java environment
# Add repo to be able to install Java 1.8
#include apt
#apt::ppa { 'ppa:openjdk-r/ppa': }

# Now, ensure java 1.8 is installed as it is the minimal required version for latest
# schemacrawler versions
#package { 'openjdk-8-jdk':
#    ensure => "installed"
#}
package { 'graphviz':
    ensure => "installed"
}

#class { 'java':
#	java_alternative_path => '/usr/lib/jvm/java-1.8.0-openjdk-amd64',
#	java_alternative => 'java-1.8.0-openjdk-amd64'
#}

# Create staging directory
@file { ['/opt/puppet/', '/opt/puppet/staging','/opt/apps', '/opt/apps/schemacrawler']:
  ensure => 'directory',
}
realize [File['/opt/puppet/'], File['/opt/puppet/staging'], File['/opt/apps'], File['/opt/apps/schemacrawler']]

# Download the archive and put it in the staging area
class { 'staging':
  path  => '/opt/puppet/staging',
  owner => 'puppet',
  group => 'puppet',
}
staging::file { "schemacrawler-${version}-main.zip":
  source => "https://github.com/sualeh/SchemaCrawler/releases/download/v${version}/schemacrawler-${version}-main.zip",
  environment => $environment
}
# extract the zip
staging::extract { "schemacrawler-${version}-main.zip":
  target  => "/opt/apps/schemacrawler/",
#  creates => "/opt/apps/schemacrawler/schemacrawler-${version}",
  require => Staging::File["schemacrawler-${version}-main.zip"],
}
# Replace shell with proper classpath
file { "/opt/apps/schemacrawler/schemacrawler-${version}-main/_schemacrawler/schemacrawler.sh":
  source  => 'puppet:///modules/schemacrawler/schemacrawler.sh',
  mode    => 0755,
  ensure => file
}

# Add symbolic links
# Add to path
file { '/usr/bin/schemacrawler':
   ensure => 'link',
   target => "/opt/apps/schemacrawler/schemacrawler-${version}-main/_schemacrawler/schemacrawler.sh",
}
# Add for easier classpath command
file { '/opt/schemacrawler':
   ensure => 'link',
   target => "/opt/apps/schemacrawler/schemacrawler-${version}-main/_schemacrawler",
}


}
