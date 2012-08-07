module QC
  module QueueCallbacks
    extend ActiveSupport::Concern

    included do
      include ActiveSupport::Callbacks
      define_callbacks :enqueue, :delete, :scope => [:kind, :name]
      set_callback :enqueue, :after, QC::AutoScale.new
      set_callback :delete, :after, QC::AutoScale.new
      
      alias_method_chain :enqueue, :callbacks
      alias_method_chain :delete, :callbacks
    end

    def enqueue_with_callbacks(method, *args)
      run_callbacks :enqueue do
        enqueue_without_callbacks(method, *args)
      end
    end

    def delete_with_callbacks(id)
      run_callbacks :delete do
        delete_without_callbacks(id)
      end
    end
  end
end

