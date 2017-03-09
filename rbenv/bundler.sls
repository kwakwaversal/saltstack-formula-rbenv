{% from "rbenv/map.jinja" import rbenv with context %}

include:
  - rbenv.install

{%- for name, args in rbenv.users.items() %}
  {%- set versions = salt["pillar.get"]("rbenv:users:" + name + ":ruby:versions", rbenv.ruby.versions) %}
  {%- for version in versions %}
rbenv-install-bundler-{{ version }}-{{ name }}:
  cmd.run:
    - unless: {{ rbenv.bin }} which bundle
    - name: {{ rbenv.bin }} exec gem install bundler
    - runas: {{ args.user }}
    - env:
      - RBENV_VERSION: {{ version }}
  {%- endfor %}
{%- endfor %}
