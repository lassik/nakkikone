class PartiesController < ApplicationController
  before_filter :admin_access
  skip_before_filter :admin_access, :only => [:show, :index]

  def index
    all_parties = Party.all

    if !current_user.is_admin
      all_parties = all_parties.select { |p| p.is_active }
    end

    render :json => all_parties, :root => false
  end

  def update
    party = Party.find params[:id]
    if party.update_attributes(party_params)
      render :json => party
    else
      render :status => 400, :json => party.errors
    end
  end

  def new
    party = Party.new(party_params)
    if party.save
      render :json => party
    else
      render :status => 400, :json => party.errors
    end
  end

  def create
    self.new
  end

  def show
    party = Party.where(:title => params[:id]).first
    if party && (party.is_active || current_user.is_admin)
      render :json => party
    else
      render :status => 404, :text => "not found"
    end
  end

  def destroy
    Party.destroy(params[:id])
    render :json => {}
  end

  private

  def party_params
    params.require(:party).permit(:title, :description, :date, :info_date, :aux_jobs_enabled)
  end
end
