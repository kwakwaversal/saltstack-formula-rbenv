# saltstack-formula-rbenv
Install [rbenv](https://github.com/rbenv/rbenv) and [Ruby](https://www.ruby-lang.org/en/)
http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html

## Description
rbenv will be installed in ~/.rbenv. This is assumed when cloning the main
repository, when cloning rbenv-related plugins, and conditional checks for
certain salt states. It's not currently possible to change the default
installation folder without updating the whole formula.

## Available states

  - [rbenv](#rbenv)
  - [rbenv.clone](#rbenv.clone)
  - [rbenv.global](#rbenv.global)
  - [rbenv.global-packages](#rbenv.global-packages)
  - [rbenv.install](#rbenv.install)
  - [rbenv.plugins](#rbenv.plugins)
  - [rbenv.profile](#rbenv.profile)

## Basic pillar
Below is a basic pillar for the user `vagrant`. N.B., the user must exist on the
system you're salting.

```yaml
rbenv:
  # The version of ruby to be installed for all users. N.B., this can be
  # overridden per user.
  ruby:
    packages: []
    versions:
      - 2.3.3

  users:
    vagrant:
      user: vagrant
      group: vagrant
      ruby:
        global: 2.3.3
        packages_install_options:
        packages:
          - test-kitchen
        versions:
          - 2.3.3
```
