class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #CREATE /leases
  def create
    @lease = Lease.create!(lease_params)
    render json: @lease, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  def destroy
    @lease = Lease.find(params[:id])
    @lease.destroy
    head :no_content
  end

  private
  def render_not_found_response
    render json: { error: "Lease not found" }, status: :not_found
  end

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

end
