class BoardController < ApplicationController

  def new
    a = Board.new
    b = a.test(params[:coord])
    render json: b.to_json
  end

end