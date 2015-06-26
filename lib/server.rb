require 'sinatra/base'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'
DataMapper.finalize
DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }
  get '/' do
    @links = Link.all
    erb :index
  end

  post '/links' do
    url = params['url']
    title = params['title']
    Link.create(url: url, title: title)
    redirect('/')
  end
end