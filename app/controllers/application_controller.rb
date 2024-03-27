class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    # devise_parameter_sanitizerのpermitメソッド
    # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー])
    # binding.pry
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys:
                                        [:nickname,
                                        :last_name,
                                        :first_name,
                                        :furi_last_name,
                                        :furi_first_name,
                                        :date_of_birth
                                      ])
  end

end
