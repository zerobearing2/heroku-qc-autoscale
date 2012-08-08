module QC
  class AutoScale

    def after_enqueue(caller)
      Heroku::Scaler.up
    end

    def after_delete(caller)
      Heroku::Scaler.down
    end

  end
end