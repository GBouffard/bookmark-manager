require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'
local_env = "postgres://localhost/bookmark_manager_#{env}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || local_env)
DataMapper.finalize
DataMapper.auto_upgrade!
