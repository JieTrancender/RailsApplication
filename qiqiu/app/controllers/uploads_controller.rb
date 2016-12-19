class UploadsController < ApplicationController
  include ApplicationHelper

  def index
    @uptoken = uptoken
  end
end
