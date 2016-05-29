module ProgressJob
  class ProgressController < ActionController::Base

    def show
      @delayed_job = Delayed::Job.find_by_id(params[:job_id])

      not_found if @delayed_job.nil?

      percentage = !@delayed_job.progress_max.zero? ? @delayed_job.progress_current / @delayed_job.progress_max.to_f * 100 : 0
      render json: @delayed_job.attributes.merge!(percentage: percentage).to_json
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end