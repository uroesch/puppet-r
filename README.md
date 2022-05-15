# Puppet R module

This module gives you the ability to install R, but also R packages.

## Usage

To install R you need to include the class...

```puppet
class { 'r': }
```

Then define any packages you want to be installed...

```puppet
r::package { 'ggplot2': }
r::package { 'reshape': }
```

To define a package, and all required dependencies, use this format:

```puppet
r::package { 'reshape': dependencies => true, }
```

on RHEL/CentOS machines, make sure you have EPEL enabled, or R won't install
properly.

## Facts

This module add a fact called simply `r`. The fact parses the `R.version` command
into a Hash. If `R` is installed the fact looks as follows.

```
r => {
  platform => "x86_64-pc-linux-gnu",
  arch => "x86_64",
  os => "linux-gnu",
  system => "x86_64, linux-gnu",
  status => "",
  major => "4",
  minor => "1.2",
  year => "2021",
  month => "11",
  day => "01",
  svn_rev => "81115",
  language => "R",
  string => "R version 4.1.2 (2021-11-01)",
  nickname => "Bird Hippie",
  version => "4.1.2"
}
```

When `R` is not present the Hash values are set to `none`.

```
r => {
  platform => "none",
  arch => "none",
  os => "none",
  system => "none",
  status => "none",
  major => "none",
  minor => "none",
  year => "none",
  month => "none",
  day => "none",
  svn_rev => "none",
  language => "none",
  string => "none",
  nickname => "none",
  version => "none"
}
```

### Usage

```puppet
if $facts['r']['version'] == '4.1.2' { 
  ...
}
```

## Testing
Testing is done via rspec-puppet, install dependencies
```
bundle install
```
run tests
```
rspec
```
