class Apps::ApplicationController < ApplicationController
  before_action :authenticate_user!
  # Apps::ApplicationControllerを継承しているフォルダーは全てbefore_action :authenticate_user!が適用される
end