class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_group
  before_action :member_required, only: [:new, :create]
  before_action :find_post, only: [:edit, :destroy]

  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user
    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post = @group.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to group_path(@group)
  end

  private

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
  def member_required
    if !current_user.is_member_of?(@group)
      redirect_to group_path(@group)
    end
  end
end
