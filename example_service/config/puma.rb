activate_control_app
state_path 'tmp/puma.state'

before_fork do
  puts "before fork"
end

on_worker_boot do
  puts "on worker boot"
end
