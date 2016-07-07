class PartiesController < ApplicationController
  before_filter :admin_access
  skip_before_filter :admin_access, :only => [:show, :index]

  def index
    all_parties = Party.all

    if current_user.role != "admin"
      all_parties = all_parties.select { |p| is_party_active(p) }
    end

    render :json => all_parties, :root => false
  end

  def update
    party = Party.find params[:id]
    if party.update_attributes( :title => params[:title],
                                :description => params[:description],
                                :aux_jobs_enabled => params[:auxJobsEnabled],
                                :date => params[:date],
                                :info_date => params[:infoDate])
      render :json => party
    else
      render :status => 400, :json => party.errors
    end
  end

  def new
    party = Party.new( :title => params[:title],
                       :description => params[:description],
                       :aux_jobs_enabled => params[:auxJobsEnabled],
                       :date => params[:date],
                       :info_date => params[:infoDate])
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
    party = nil;
    if (params[:by_title])
      party = Party.where(:title => params[:id]).first
    elsif (params[:id].to_i == 0) #TODO remove and resolve in frontend.
      party = Party.order("date ASC").select { |p| is_party_active(p) }.first
    else
      party = Party.find(params[:id])
    end

    if party && is_party_active(party) || current_user.role == "admin"
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
  def is_party_active(party)
    3.days.ago < party.date && party.date < 4.weeks.from_now
  end
end
