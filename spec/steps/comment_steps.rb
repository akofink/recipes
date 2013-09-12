module CommentSteps
  def create_comment_through_ui(args = {})
    login
    create_recipe_through_ui
    fill_form valid_ui_comment_args
    click_button 'Create Comment'
  end

  def create_comment(args = {})
    create comment, valid_comment_args.merge(args)
  end

  def go_to_comment
    visit comments_path(@comment)
  end

  def valid_comment(args = {})
    @comment ||= create_comment args
  end

  def valid_comment_args(args = {})
    {
      body: 'test body'
    }.merge args
  end

  def valid_ui_comment_args(args = {})
    {
      comment_body: 'test body'
    }.merge args
  end
end
