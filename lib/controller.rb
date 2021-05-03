require '../the_gossip_project_sinatra/lib/gossip.rb'
require '../the_gossip_project_sinatra/lib/comment.rb'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.show_all}
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  get '/gossips/:id' do
    erb :gossip_id, locals: {gossip: Gossip.show_gossip(params['id']), comments: Comment.get_gossip_comments(params['id'])}
  end
  get '/gossips/:id/edit' do
    erb :edit
  end
  post '/gossips/:id/edit' do
    Gossip.update(params["id"], params["updated_author"], params["updated_content"])
    redirect '/'
  end
  get '/gossips/:id/comment/new' do
    erb :comment
  end 
  post '/gossips/:id/comment/new' do 
  	Comment.new(params["id"], params["comment_author"], params["comment_content"]).save
    redirect "/gossips/#{params['id']}" 
  end
end