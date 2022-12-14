class RoomIdeasController < ApplicationController
  before_action :sign_in_required
  before_action :set_room_idea, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user, only: [:show, :edit, :update, :destroy]

  # GET /room_ideas
  def index
    @room_ideas = current_user.room_ideas.all.order("id DESC")
  end

  # GET /room_ideas/1
  def show
  end

  # GET /room_ideas/new
  def new
    @room_idea = RoomIdea.new
  end 

  # GET /room_ideas/1/edit
  def edit
  end

  # POST /room_ideas
  def create
    @room_idea = RoomIdea.new(room_idea_params)
    @room_idea.user_id = current_user.id

    if @room_idea.save
      redirect_to @room_idea, notice: 'ルームアイデアが新規作成されました！'
    else
      render :new
    end
  end

  # PATCH/PUT /room_ideas/1
  def update
    if @room_idea.update(room_idea_params)
      redirect_to @room_idea, notice: 'ルームアイデアが更新されました！'
    else
      render :edit
    end
  end

  # DELETE /room_ideas/1
  def destroy
    @room_idea.destroy
    redirect_to room_ideas_url, notice: 'ルームアイデアが削除されました！'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room_idea
      @room_idea = RoomIdea.find(params[:id])
    end

    def ensure_user
      @users = current_user
      @user = @room_idea.user
      redirect_to room_ideas_path, notice: "他ユーザのルームアイデア閲覧・更新はできません" if @user != @users
    end

    # Only allow a trusted parameter "white list" through.
    def room_idea_params
      params.require(:room_idea).permit(:name, :color, :width, :depth, :height, :image, :image_cache, :content)
    end
end
