class InstructorsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :create_error
    rescue_from ActiveRecord::RecordNotFound, with: :no_record

    def index
        instructors = Instructor.all
        render json: instructors
    end

    def create
        instructor = Instructor.create!(name: params[:name])
        render json: instructor
    end

    def update
        instructor = Instructor.find_by!(id: params[:id])
        instructor.update(name: params[:name])
        render json: instructor
    end

    def destroy
        instructor = Instructor.find_by!(id: params[:id])
        instructor.destroy
    end

    private

    def create_error
        render json: {error: "oops"}, status: :unprocessable_entity
    end

    def no_record
        render json: {error: "record not found"}, status: :not_found
    end
end
