class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
    def index
        render json: Student.all
    end

    def show
        render json: find_student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :accepted
    end

    def destroy 
        student = find_student
        student.destroy
        head :no_content
    end

    private

    def record_not_found
        render json: { error: 'Student not found' }, status: :not_found
    end

    def record_invalid e 
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
