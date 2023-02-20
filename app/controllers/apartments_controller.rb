class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

# GET /apartments
def index
  @apartments = Apartment.all 
  render json: @apartments
end

# GET /apartments/:id
def show 
  @apartment = find_apartment
  render json: @apartment
end

# POST /apartments
def create
  @apartment = Apartment.create!(apartment_params)
  render json: @apartment, status: :created
rescue ActiveRecord::RecordInvalid => invalid
  render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
end

#UPDATE /apartments/:id
def update
  @apartment = find_apartment
  @apartment.update!(apartment_params)
  render json: @apartment, status: :accepted
end

# DESTROY
def destroy 
  @apartment = find_apartment
  @apartment.destroy
  head :no_content
end

private
def render_not_found_response
  render json: { error: "Apartment not found" }, status: :not_found
end

# Find an apartment
def find_apartment
  Apartment.all.find(params[:id])
end

# apartment params
def apartment_params
  params.permit(:number)
end

end
