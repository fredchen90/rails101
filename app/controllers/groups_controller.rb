class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_current_group, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_param)
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_param)
      redirect_to groups_path
    else
      render :edit
    end

  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def join
    @group = Group.find(params[:id])
    unless current_user.is_member_of?(@group)
      current_user.join!(@group)
    end
    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])
    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
    end
    redirect_to group_path(@group)
  end

  private

  def find_current_group
     @group = current_user.groups.find(params[:id])
  end

  def group_param
    params.require(:group).permit(:title, :description)
  end
end
