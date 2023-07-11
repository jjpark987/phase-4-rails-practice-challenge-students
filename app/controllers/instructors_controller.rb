class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
    def index
        render json: Instructor.all
    end

    def show
        render json: find_instructor
    end

    def create
        instructor = Instructor.create!(name: params[:name])
        render json: instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(name: params[:name])
        render json: instructor, status: :accepted
    end

    def destroy 
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: 'Instructor not found' }, status: :not_found
    end

    def record_invalid e 
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_instructor
        Instructor.find(params[:id])
    end
end
