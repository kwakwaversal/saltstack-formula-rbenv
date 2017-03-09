{% from "rbenv/map.jinja" import rbenv with context %}

include:
  - rbenv.clone
  - rbenv.plugins
  - rbenv.profile

rbenv-install:
  pkg.installed:
    - names:
      - build-essential
      - curl
      - libffi-dev
      - libgdbm-dev
      - libgdbm3
      - libncurses5-dev
      - libreadline6-dev
      - libssl-dev
      - libyaml-dev
      - zlib1g-dev

{%- for name, args in rbenv.users.items() %}
  {%- set versions = salt["pillar.get"]("rbenv:users:" + name + ":ruby:versions", rbenv.ruby.versions) %}
  {%- for version in versions %}
rbenv-install-{{ version }}-{{ name }}:
  cmd.run:
    - unless: {{ rbenv.bin }} versions | grep {{ version }}
    - name: {{ rbenv.bin }} install {{ version }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
