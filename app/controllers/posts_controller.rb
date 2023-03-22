class PostsController < ApplicationController
  skip_forgery_protection
  def create
    respond_to do |format|
      format.json { render json: Post.create(title: params[:title], description: params[:description]).to_json }
    end
  end

  def index
    respond_to do |format|
      format.json { render json: Post.all.to_json }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: Post.find(params[:id]).to_json }
    end
  end
end
