class PerfilesController < ApplicationController
  before_action :set_perfil, only: [:edit]

  def edit
  end

  def update
    
  end

  private

    def set_perfil
      @user = User.find(params[:id])
    end
end
