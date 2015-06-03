require 'spec_helper'

describe RecipesController do
  let(:recipes_controller) { RecipesController.new }
  let(:user) { double User }
  let(:recipe) { double Recipe }
  let(:recipes) { double 'recipes' }
  let(:flash) { ActionController::Parameters.new }
  let(:params) { ActionController::Parameters.new }
  let(:errors) { ActionController::Parameters.new }

  describe 'actions' do
    before(:each) do
      allow(recipes_controller).to receive(:flash).and_return flash
      allow(recipes_controller).to receive(:params).and_return params
      allow(recipes_controller).to receive :render
      allow(recipes_controller).to receive :redirect_to
      allow(recipes_controller).to receive(:set_recipe).and_return recipe
      allow(recipes_controller).to receive(:recipe).and_return recipe
      allow(recipes).to receive(:page).and_return 1
      allow(errors).to receive(:full_messages).and_return ''
      allow(params).to receive(:require).and_return params
      allow(params).to receive(:permit).and_return params
    end

    describe '#destroy' do
      it 'destroys the recipe' do
        expect(recipe).to receive(:destroy).and_return recipe
        recipes_controller.destroy
      end

      it 'redirects to the home page on success' do
        allow(recipe).to receive(:destroy).and_return recipe
        expect(recipes_controller).to receive(:redirect_to).with :root
        recipes_controller.destroy
      end

      it 'errs back' do
        allow(recipe).to receive(:destroy)
        expect(recipes_controller).to receive :redirect_back
        recipes_controller.destroy
      end
    end

    describe '#edit' do
      it 'uses an existing recipe' do
        expect(recipes_controller).to receive(:set_recipe)
        recipes_controller.edit
      end
    end

    describe '#filter' do
      it 'uses the filter method of the Recipe model' do
        allow(recipes_controller).to receive(:paginated_recipes).and_return recipes
        expect(recipes).to receive :filter
        recipes_controller.filter
      end
    end

    describe '#create' do
      it 'saves valid users' do
        expect(Recipe).to receive(:new).and_return recipe
        expect(recipe).to receive(:save).and_return true
        recipes_controller.create
        expect(flash[:success]).to_not be_nil
      end

      it 'handles invalid users' do
        expect(Recipe).to receive(:new).and_return recipe
        expect(recipe).to receive :save
        expect(recipe).to receive(:errors).and_return errors
        recipes_controller.create
        expect(flash[:error]).to_not be_nil
      end
    end

    describe '#index' do
      it 'orders the recipes of a user by title' do
        expect(recipes_controller).to receive(:user)
          .at_least(:once).and_return user
        expect(user).to receive(:recipes).and_return recipes
        expect(recipes).to receive(:order).with(:title).and_return recipes
        recipes_controller.index
      end

      it 'orders all recipes by title' do
        expect(recipes_controller).to receive(:user).and_return nil
        allow(Recipe).to receive(:all).and_return recipe
        expect(recipe).to receive(:order).with(:title).and_return recipes
        recipes_controller.index
      end
    end

    describe '#new' do
      it 'uses a new recipe' do
        expect(Recipe).to receive :new
        recipes_controller.new
      end
    end

    describe '#show' do
      it 'shows the current recipe' do
        expect(recipes_controller).to receive :set_recipe
        recipes_controller.show
      end
    end

    describe '#update' do
      it 'updates using safe parameters' do
        expect(recipe).to receive(:update).with(params).and_return true
        recipes_controller.update
      end

      it 'errs back to recipes#new' do
        allow(recipe).to receive(:update)
        allow(recipe).to receive(:errors).and_return errors
        allow(errors).to receive(:full_messages)
        expect(recipes_controller).to receive(:render).with :edit
        recipes_controller.update
      end
    end
  end
end
