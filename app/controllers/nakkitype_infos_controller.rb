class NakkitypeInfosController < ApplicationController
  before_filter :admin_access
  skip_before_filter :admin_access, :only => [:party_index]

  include NakkitypeInfoHelper

  def party_index
    current_party = get_current_party
    nakkitype_descriptions = current_party.nakkitypes.map { |n| n.nakkitype_info }
    render :json => nakkitype_descriptions, :root => false
  end

  def index
    render :json => NakkitypeInfo.all, :root => false
  end

  def create
    info = NakkitypeInfo.new(info_params)
    if info.save
      render :json => info
    else
      render :status => 400, :json => info.errors
    end
  end

  def update
    info = NakkitypeInfo.find params[:id]

    if info.update_attributes(info_params)
      render :json => info
    else
      render :status => 400, :json => info.errors
    end
  end

  def destroy
    NakkitypeInfo.destroy(params[:id])
    render :json => {}
  end

  private

  def info_params
    tmp = params.require(:nakkitype_info).permit(:id, :title, :description)
    tmp[:title] = if tmp[:title].eql? "_generate_" then generate_name_from_seq else tmp[:title] end ##TODO should this be handled by model?
    return tmp
  end
end
