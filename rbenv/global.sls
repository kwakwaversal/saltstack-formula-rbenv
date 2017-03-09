{% from "rbenv/map.jinja" import rbenv with context %}

include:
  - rbenv.install

{%- for name, args in rbenv.users.items() %}
  {%- set version = salt["pillar.get"]("rbenv:users:" + name + ":ruby:global", rbenv.ruby.global) %}
  {%- if version %}
rbenv-global-{{ name }}:
  cmd.run:
    - onlyif: {{ rbenv.bin }} versions | grep {{ version }}
    - name: {{ rbenv.bin }} global {{ version }}
    - runas: {{ args.user }}
    - require:
      - cmd: rbenv-install-{{ version }}-{{ name }}
  {%- endif %}
{%- endfor %}
