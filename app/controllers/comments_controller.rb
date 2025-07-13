class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :is_an_authorized_user, only: [:show, :index]

  def index
    raise ActiveRecord::RecordNotFound, "Not authorized"
  end

  def show
    # Nothing needed here, before_action handles 404
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: root_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to root_url, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound, "Comment not found" if @comment.nil?
  end

  def is_an_authorized_user
    raise ActiveRecord::RecordNotFound, "Not authorized to view comment"
  end

  def comment_params
    params.require(:comment).permit(:author_id, :photo_id, :body)
  end
end
