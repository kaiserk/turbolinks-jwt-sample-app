class ScriptsController < ApplicationController
  protect_from_forgery except: :widget
  before_action only: [:widget]

  def home
  end

  def widget

    respond_to do |format|
      format.js
      format.css
    end

  end

end
