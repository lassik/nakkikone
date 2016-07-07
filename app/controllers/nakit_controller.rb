class NakitController < ApplicationController

  def index
    current_party = get_current_party
    nakkilist = []
    current_party.nakkitypes.each{ |t| nakkilist += t.nakkis }

    render :json => nakkilist, :root => false
  end

  def update
    nakki = Nakki.find(params[:id])
    if nakki.user.nil? || current_user.role == "admin"
       nakki.user = current_user
    else
      render :status => 409, :text => "nakki has allready been reserved"
      return
    end

    if nakki.save
      render :json => nakki
    else
      render :status => 500, :text => "what what"
    end
  end
end
