class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :analytics

  WORD_LIBRARY = %w(
    how
    do
    i
    cancel
    my
    subscription
    what
    is
    account
    number
    subscription
    signup
  )

  def analytic
    respond_to do |format|
      format.js do
        phrase = params[:phrase].to_s.squish.gsub(/\?|\!|\./, '')
        unless detect_incomplete_word?(phrase)
          analytic = Analytic.where('phrase ILIKE ?', phrase).first_or_initialize(phrase: phrase)
          analytic.count += 1 if analytic.persisted?
          analytic.save
        end
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

    def detect_incomplete_word?(phrase)
      phrase_array = phrase.downcase.split(' ')
      (phrase_array & WORD_LIBRARY).size != phrase_array.size
    end
end
