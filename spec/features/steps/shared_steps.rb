module SharedSteps
  def go_to_root
    visit '/'
  end

  def fill_form(args)
    within('form') do
      args.each do |k, v|
        fill_in k.to_s, with: v
      end
    end
  end
end
