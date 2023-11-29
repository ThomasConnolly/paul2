# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :all_posts, only: %i[index create update destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @pray_fors = PrayFor.all
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    return unless @post.save

    redirect_to(posts_path)
    PostMailer.post_created(@post).deliver_now
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to(@post, notice: 'Post was successfully updated.')
    else
      render(:edit)
    end
  end

  def destroy
    @post.destroy
    redirect_to(posts_url, status: :see_other, notice: 'Post was successfully destroyed.')
  end

  private

  def all_posts
    @posts = Post.all
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :submit, :picture, photos: [])
  end
end
