class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :create_error

    def index
        students= Student.all
        render json: students
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def destroy
        student = Student.find_by!(id: params[:id])
        student.destroy
    end

    def update
        student = Student.find_by!(id: params[:id])
        student.update(student_params)
        render json: student
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def create_error
        render json: {errors: [:validation_errors]}, status: :unprocessable_entity
    end

end
