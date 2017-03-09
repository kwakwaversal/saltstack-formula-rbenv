{% from "rbenv/map.jinja" import rbenv with context %}

include:
  - rbenv.clone

{%- for name, args in rbenv.users.items() %}
  {%- for plugin, gitrepo in rbenv.plugins.items() %}
rbenv-plugins-{{ plugin }}-{{ name }}:
  cmd.run:
    - unless: test -d ~/.rbenv/plugins/{{ plugin }}
    - name: git clone {{ gitrepo }} ~/.rbenv/plugins/{{ plugin }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
