{% from "rbenv/map.jinja" import rbenv with context %}

rbenv-clone:
  pkg.installed:
    - names:
      - git

{%- for name, args in rbenv.users.items() %}
rbenv-clone-{{ name }}:
  cmd.run:
    - unless: test -d ~/.rbenv
    - name: git clone {{ salt["pillar.get"]("rbenv:users:" + name + ":repository", rbenv.repository) }} ~/.rbenv
    - runas: {{ args.user }}
{%- endfor %}
