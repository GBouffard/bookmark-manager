require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/users'
require_relative 'controllers/sessions'

enable :sessions
set :session_secret, 'unique encryption key'
use Rack::Flash
use Rack::MethodOverride

get '/' do
  @links = Link.all
  erb :index
end
