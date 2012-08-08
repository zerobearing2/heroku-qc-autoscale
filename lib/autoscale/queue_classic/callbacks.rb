module Autoscale
  module QueueClassic
  
    class ScaleObserver
      def after_enqueue(caller)
        Autoscale::Heroku.up
      end

      def after_delete(caller)
        Autoscale::Heroku.down
      end
    end

    module QueueCallbacks
      extend ActiveSupport::Concern

      included do
        include ActiveSupport::Callbacks
        define_callbacks :enqueue, :delete, :scope => [:kind, :name]
        set_callback :enqueue, :after, ScaleObserver.new
        set_callback :delete, :after, ScaleObserver.new
        
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
end

