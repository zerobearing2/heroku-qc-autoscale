module QC
  class AutoScale

    def after_enqueue(caller)
      puts "autoscaling workers after enqueue!"
    end

    def after_delete(caller)
      puts "autoscaling workers after delete from queue!"
    end

  end
end