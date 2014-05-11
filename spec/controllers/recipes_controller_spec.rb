require 'spec_helper'

describe RecipesController do
  let(:recipes_controller) { RecipesController.new }
  let(:user) { mock_model User }
  let(:recipe) { mock_model Recipe }
  let(:recipes) { double 'recipes' }
  let(:flash) { Hash.new }
  let(:params) { Hash.new }
  let(:errors) { Hash.new }

  describe 'actions' do
    before(:each) do
      recipes_controller.stub(:flash).and_return flash
      recipes_controller.stub(:recipe_params).and_return params
      recipes_controller.stub(:params).and_return params
      recipes_controller.stub :render
      recipes_controller.stub :redirect_to
      recipes_controller.stub(:set_recipe).and_return recipe
      recipes_controller.stub(:recipe).and_return recipe
      recipes.stub(:page).and_return 1
      errors.stub(:full_messages).and_return ''
    end

    describe '#destroy' do
      it 'destroys the recipe' do
        recipe.should_receive(:destroy).and_return recipe
        recipes_controller.destroy
      end

      it 'redirects to the home page on success' do
        recipe.stub(:destroy).and_return recipe
        recipes_controller.should_receive(:redirect_to).with :root
        recipes_controller.destroy
      end

      it 'errs back' do
        recipe.stub(:destroy)
        recipes_controller.should_receive :redirect_back
        recipes_controller.destroy
      end
    end

    describe '#edit' do
      it 'uses an existing recipe' do
        recipes_controller.should_receive(:set_recipe)
        recipes_controller.edit
      end
    end

    describe '#filter' do
      it 'uses the filter method of the Recipe model' do
        recipes_controller.stub(:paginated_recipes).and_return recipes
        recipes.should_receive :filter
        recipes_controller.filter
      end
    end

    describe '#create' do
      it 'saves valid users' do
        Recipe.should_receive(:new).and_return recipe
        recipe.should_receive(:save).and_return true
        recipes_controller.create
        flash[:success].should_not be_nil
      end

      it 'handles invalid users' do
        Recipe.should_receive(:new).and_return recipe
        recipe.should_receive :save
        recipe.should_receive(:errors).and_return errors
        recipes_controller.create
        flash[:error].should_not be_nil
      end
    end

    describe '#index' do
      it 'orders the recipes of a user by title' do
        recipes_controller.should_receive(:user)
          .at_least(:once).and_return user
        user.should_receive(:recipes).and_return recipes
        recipes.should_receive(:order).with(:title).and_return recipes
        recipes_controller.index
      end

      it 'orders all recipes by title' do
        recipes_controller.should_receive(:user).and_return nil
        Recipe.stub(:all).and_return recipe
        recipe.should_receive(:order).with(:title).and_return recipes
        recipes_controller.index
      end
    end

    describe '#new' do
      it 'uses a new recipe' do
        Recipe.should_receive :new
        recipes_controller.new
      end
    end

    describe '#show' do
      it 'shows the current recipe' do
        recipes_controller.should_receive :set_recipe
        recipes_controller.show
      end
    end

    describe '#update' do
      it 'updates using safe parameters' do
        recipe.should_receive(:update).with(params).and_return true
        recipes_controller.update
      end

      it 'errs back to recipes#new' do
        recipe.stub(:update)
        recipes_controller.should_receive(:render).with :edit
        recipes_controller.update
      end
    end
  end
end
