{% from "rbenv/map.jinja" import rbenv with context %}

include:
  - rbenv.install
  - rbenv.bundler

{%- for name, args in rbenv.users.items() %}
  {%- set ruby_install_options = salt["pillar.get"]("rbenv:users:" + name + ":ruby:packages_install_options", rbenv.ruby.packages_install_options)  %}
  {%- set versions = salt["pillar.get"]("rbenv:users:" + name + ":ruby:versions", rbenv.ruby.versions) %}
  {%- for version in versions %}
    {%- set pkgs = salt["pillar.get"]("rbenv:users:" + name + ":ruby:packages", rbenv.ruby.packages) %}
    {%- for pkg in pkgs %}
rbenv-global-pkgs-{{ version }}-{{ pkg }}-{{ name }}:
  cmd.run:
    - unless: {{ rbenv.bin }} list-modules | grep {{ pkg }}
    - name: |
        {{ rbenv.bin }} exec cpanm {{ ruby_install_options }} {{ pkg }}
        {{ rbenv.bin }} rehash
    - runas: {{ args.user }}
    - env:
      - RBENV_VERSION: {{ version }}
    {%- endfor %}
  {%- endfor %}
{%- endfor %}
