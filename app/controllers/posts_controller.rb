class PostsController < BaseController
#  skip_forgery_protection
  def create
    render(json: Post.create(title: params[:title], description: params[:description]).to_json, status: 200)
  end

  def index
    render(json: Post.all.to_json, status: 200)
  end

  def show
    render(json: Post.find(params[:id].to_json), status: 200)
  end
end
