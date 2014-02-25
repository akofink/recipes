class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    @comment.save!
    redirect_to @comment.recipe
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.delete
    render partial: 'all', locals: { comments: @comment.recipe.comments.chronological }
  end

  def edit
    @comment = Comment.find params[:id]
    render partial: 'form', locals: {
      comment: @comment,
      recipe: @comment.recipe
    }
  end

  def new
    @comment = Comment.new
    @comment.user = current_user
    render partial: 'form', locals: {
      comment: @comment,
      recipe: Recipe.find(params[:recipe_id])
    }
  end

  def update
    @comment = Comment.find params[:id]
    @comment.update_attributes comment_params
    redirect_to @comment.recipe
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
      current_user
    when 'edit', 'destroy'
      current_user == Comment.find(args[:id]).user
    when 'update'
      current_user.id == args[:comment][:user_id]
    end
  end
end
