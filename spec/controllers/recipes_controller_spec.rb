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
      recipes_controller.stub :render
      recipes_controller.stub :redirect_to
      errors.stub(:full_messages).and_return ''
    end

    describe '#index' do
      it 'orders the recipes of a user by title' do
        recipes_controller.should_receive(:user).at_least(:once).and_return user
        user.should_receive(:recipes).and_return recipes
        recipes.should_receive(:order).with :title
        recipes_controller.index
      end

      it 'orders all recipes by title' do
        recipes_controller.should_receive(:user).and_return nil
        Recipe.should_receive(:order).with :title
        recipes_controller.index
      end
    end

    describe '#show' do
      it 'shows the current recipe' do
        recipes_controller.should_receive :set_recipe
        recipes_controller.show
      end
    end

    describe '#new' do
      it 'uses a new recipe' do
        Recipe.should_receive :new
        recipes_controller.new
      end
    end

    describe '#edit' do
      it 'uses an existing recipe' do
        recipes_controller.should_receive(:set_recipe)
        recipes_controller.edit
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

    describe '#update' do
    end

    describe '#destroy' do
    end

    describe '#delete' do
    end
  end
end
