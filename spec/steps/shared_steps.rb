module SharedSteps
  def go_to_root
    visit '/'
  end

  def fill_form(args)
    within(args[:form] || 'form') do
      args.each do |k, v|
        fill_in k.to_s, with: v
      end
    end
  end

  def create(model, args = {})
    args = valid_recipe_args.merge args
    model.create!(args)
  end
end
