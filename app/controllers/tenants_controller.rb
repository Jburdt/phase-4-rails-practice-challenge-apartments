class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  #GET /tenants
  def index
    @tenants = Tenant.all 
    render json: @tenants
  end

  #GET /tenants/:id
  def show
    @tenant = find_tenant
    render json: @tenant
  end

  #POST /tenants
  def create
   @tenant = Tenant.create!(tenant_params)
    render json: @tenant, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  #UPDATE /tenants/:id
  def update
    @tenant = find_tenant
    @tenant.update!(tenant_params)
    render json: @tenant
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  #DESTROY /tentant/:id
  def destroy
    @tenant = find_tenant
    @tenant.destroy
    head :no_content
  end

  private
  def render_not_found_response
    render json: { error: "Tenants not found" }, status: :not_found
  end

  # Finds a tenant by id
  def find_tenant
    Tenant.all.find(params[:id])
  end

  #tenant params
  def tenant_params
    params.permit(:name, :age)
  end

end
