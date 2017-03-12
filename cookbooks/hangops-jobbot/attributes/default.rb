# some sensible defaults

# Choose daemonize program: 'runit' or 'supervisor'
default['hangops-jobbot']['daemon'] = 'runit'

# We'd like some logging please!
# Use true to log to /var/log/hubot, false turns it off
default['hangops-jobbot']['runit']['default_logger'] = true

# defaults that RUNIT service needs
default['hangops-jobbot']['install_dir'] = '/srv/hangops-jobbot'
default['hangops-jobbot']['user'] = 'root'
default['hangops-jobbot']['adapter'] = 'slack'
default['hangops-jobbot']['name'] = 'hangops-jobbot'
