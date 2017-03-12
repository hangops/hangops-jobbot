include_recipe 'runit'

runit_service 'hangops-jobbot' do
  options node['hangops-jobbot'].to_hash
  env node['hangops-jobbot']['config']
  default_logger node['hangops-jobbot']['runit']['default_logger']
end