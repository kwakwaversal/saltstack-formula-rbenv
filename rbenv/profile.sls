{% from "rbenv/map.jinja" import rbenv with context %}

{%- for name, args in rbenv.users.items() %}
rbenv-profile-exists-{{ name }}:
  file.managed:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("rbenv:users:" + name + ":profile", rbenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("rbenv:users:" + name + ":profile", rbenv.profile) }}
    {%- endif %}
    - user: {{ args.user }}
    - group: {{ args.user }}
    - mode: 644

rbenv-profile-append-{{ name }}:
  file.append:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("rbenv:users:" + name + ":profile", rbenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("rbenv:users:" + name + ":profile", rbenv.profile) }}
    {%- endif %}
    - source: salt://rbenv/files/.bash_profile
{%- endfor %}
