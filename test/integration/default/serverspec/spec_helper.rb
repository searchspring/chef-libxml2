require 'serverspec'

set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'
  end
end