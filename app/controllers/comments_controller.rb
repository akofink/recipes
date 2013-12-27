class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    @comment.save!
    render partial: 'show', locals: { comment: @comment }
  end

  def destroy
  end

  def edit
    @comment = Comment.find params[:id]
    render partial: 'form', locals: { comment: @comment }
  end

  def new
    @comment = Comment.new
    @comment.user = current_user
    render partial: 'form', locals: { comment: @comment }
  end

  def update
    @comment = Comment.find params[:id]
    @comment.update_attributes comment_params
    render partial: 'show', locals: { comment: @comment }
  end

  private

  def comment_params
    params
    .require(:comment)
    .permit(
      :body,
      :user_id,
      :recipe_id
    )
  end

  def action_allowed?(args = params)
    case args[:action]
    when 'create', 'new'
      if current_user
        render nothing: true, status: 400
      end
    when 'update', 'edit', 'destroy'
      current_user == args[:comment].user
    end
  end
end
