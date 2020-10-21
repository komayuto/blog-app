class ApplicationController < ActionController::Base

  # ActiveDecoratorで使用するcurrent_userのためのコード
  # current_userがActiveDecoratorとの相性が良くないためApplicationController で定義している
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end
end
