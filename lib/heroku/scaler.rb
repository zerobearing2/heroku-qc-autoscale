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

      def app
        ::Heroku::QC::Autoscale.app
      end

      def client
        @@client ||= ::Heroku::API.new( ::Heroku::QC::Autoscale.heroku_params )
      end
    end

  end
  
end