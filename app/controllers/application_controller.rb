class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :analytics

  def analytic
    respond_to do |format|
      format.js do
        phrase = params[:phrase].to_s.squish
        analytic = Analytic.where('phrase ILIKE ?', phrase).first_or_initialize(phrase: phrase)
        analytic.count += 1 if analytic.persisted?
        analytic.save
      end
    end
  end

  def clear_analytic
    respond_to do |format|
      format.js do
        Analytic.delete_all
        render :analytic
      end
    end
  end

  private
    def analytics
      @analytics = Analytic.order(:phrase)
    end
end
