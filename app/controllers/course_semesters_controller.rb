class CourseSemestersController < ApplicationController
  before_action :set_course_semester, only: [:show, :edit, :update, :destroy]

  # GET /course_semesters
  # GET /course_semesters.json
  def index
    @course_semesters = CourseSemester.all
  end

  # GET /course_semesters/1
  # GET /course_semesters/1.json
  def show
  end

  # GET /course_semesters/new
  def new
    @course_semester = CourseSemester.new
  end

  # GET /course_semesters/1/edit
  def edit
  end

  # POST /course_semesters
  # POST /course_semesters.json
  def create
    @course_semester = CourseSemester.new(course_semester_params)

    respond_to do |format|
      if @course_semester.save
        format.html { redirect_to @course_semester, notice: 'Course semester was successfully created.' }
        format.json { render :show, status: :created, location: @course_semester }
      else
        format.html { render :new }
        format.json { render json: @course_semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_semesters/1
  # PATCH/PUT /course_semesters/1.json
  def update
    respond_to do |format|
      if @course_semester.update(course_semester_params)
        format.html { redirect_to @course_semester, notice: 'Course semester was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_semester }
      else
        format.html { render :edit }
        format.json { render json: @course_semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_semesters/1
  # DELETE /course_semesters/1.json
  def destroy
    @course_semester.destroy
    respond_to do |format|
      format.html { redirect_to course_semesters_url, notice: 'Course semester was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_semester
      @course_semester = CourseSemester.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_semester_params
      params.require(:course_semester).permit(:semester_id, :course_id)
    end
end
