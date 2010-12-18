module  ActionDispatch::Routing::Mapper::Resources
  class Resource

    def default_actions_with_delete
      default_actions_without_delete + [:delete]
    end

    alias_method_chain :default_actions, :delete
  end

  def resources(*resources, &block)
    options = resources.extract_options!

    if apply_common_behavior_for(:resources, resources, options, &block)
      return self
    end

    resource_scope(Resource.new(resources.pop, options)) do
      yield if block_given?

      collection do
        get  :index if parent_resource.actions.include?(:index)
        post :create if parent_resource.actions.include?(:create)
      end

      new do
        get :new
      end if parent_resource.actions.include?(:new)

      member do
        get    :edit if parent_resource.actions.include?(:edit)
        get    :delete if parent_resource.actions.include?(:delete)
        get    :show if parent_resource.actions.include?(:show)
        put    :update if parent_resource.actions.include?(:update)
        delete :destroy if parent_resource.actions.include?(:destroy)
      end
    end

    self
  end

end

