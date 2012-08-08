module Autoscale
  class Heroku
    
    class << self

      def workers
        client.get_app(app).body.fetch("workers", 0).to_i
      end

      def workers=(qty)
        client.put_workers(app, qty) 
      end

      def job_count
        QC::Queries.count.to_i
      end

      # scale workers based on scale
      def up
        unless calculate_required_workers <= workers
          QC.log(action: :scale, workers: calculate_required_workers)
          self.workers = calculate_required_workers
        end
      end

      # shutdown if no jobs exist
      def down
        if job_count < 1
          QC.log(action: :scale, workers: 0)
          self.workers = 0
        end
      end

      def calculate_required_workers
        scale.rindex{|x| x <= job_count} + 1
      end

      def params
        {
          api_key: Autoscale.api_key  || ENV['HEROKU_API_KEY'],
          mock:    Autoscale.mock     || false
        }
      end
      
      # the app to scale
      def app
        Autoscale.app
      end

      # the scale
      def scale
        Autoscale.scale || [1, 15, 30, 40, 50]
      end

      # heroku api client
      def client
        @@client ||= ::Heroku::API.new( params )
      end
    end

  end
  
end