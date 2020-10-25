class ApplicationController < ActionController::Base

  before_action :set_locale
  # ApplicationControllerの中にbefore_actionを入れることで全てのアクションのことをさせる

  # ActiveDecoratorで使用するcurrent_userのためのコード
  # current_userがActiveDecoratorとの相性が良くないためApplicationController で定義している
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def default_url_options
    # default_url_optionsはrailsルールで元々設定されているためbefore_actionしなくていよい
    { locale: I18n.locale }
    # locale3000状態でI18n.localeを最初から取得する
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    # params[:locale]で英語設定。I18n.default_localeで日本語設定。英語がなければデフォルトの日本語
  end

end
