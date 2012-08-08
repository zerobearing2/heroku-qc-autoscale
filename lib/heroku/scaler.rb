module Heroku
  class Scaler
    
    class << self
      def workers
        client.get_app(app).body.fetch("workers", 0).to_i
      end

      def workers=(qty)
        client.put_workers(app, qty) 
      end

      def job_count
        ::QC::Queries.count.to_i
      end

      # scale workers based on scale
      def up
        self.workers = calculate_required_workers unless calculate_required_workers <= workers
      end

      # shutdown if no jobs exist
      def down
        self.workers = 0 if job_count < 1
      end

      def calculate_required_workers
        scale.rindex{|x| x <= job_count} + 1
      end

      # the app to scale
      def app
        ::Heroku::QC::Autoscale.app
      end

      # the scale
      def scale
        ::Heroku::QC::Autoscale.scale || [1, 15, 30, 40, 50]
      end

      # heroku api client
      def client
        @@client ||= ::Heroku::API.new( ::Heroku::QC::Autoscale.heroku_params )
      end
    end

  end
  
end