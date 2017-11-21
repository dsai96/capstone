class StudentSectionsController < ApplicationController
  before_action :set_student_section, only: [:show, :edit, :update, :destroy]

  # GET /student_sections
  # GET /student_sections.json
  def index
    @latest_semester = Semester.all.chronological.last
    @student_sections = StudentSection.all
    @some_data = Course.first(10).map { |m| m.id }
    respond_to do |format|
      format.html
      format.json
    end
  end

  # POST /add_section
  def add_section_to_student

    @student = Student.all.first
    @sections = Section.for_course(params[:course_id])

    puts "student"
    puts params[:course_id]
    puts @student.fname 
    puts @sections.size

    @sections.each do |sec|
      stuSec = StudentSection.new
      stuSec.student = @student
      stuSec.section = sec
      stuSec.added = true
      stuSec.save
    end

    all_sections = StudentSection.where(student: @student)
    @divya = []
    all_sections.each do |s|
      unless @divya.include?(s.section.course)
        @divya.push(s.section.course)
      end
    end

    puts @divya.map { |e| e.name }
    respond_to do |format|
      format.js
    end

  end

  # GET /student_sections/1
  # GET /student_sections/1.json
  def show
  end

  # GET /student_sections/new
  def new
    @student_section = StudentSection.new
  end

  # GET /student_sections/1/edit
  def edit
  end

  # POST /student_sections
  # POST /student_sections.json
  def create
    @student_section = StudentSection.new(student_section_params)

    respond_to do |format|
      if @student_section.save
        format.html { redirect_to @student_section, notice: 'Student section was successfully created.' }
        format.json { render :show, status: :created, location: @student_section }
      else
        format.html { render :new }
        format.json { render json: @student_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_sections/1
  # PATCH/PUT /student_sections/1.json
  def update
    respond_to do |format|
      if @student_section.update(student_section_params)
        format.html { redirect_to @student_section, notice: 'Student section was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_section }
      else
        format.html { render :edit }
        format.json { render json: @student_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_sections/1
  # DELETE /student_sections/1.json
  def destroy
    @student_section.destroy
    respond_to do |format|
      format.html { redirect_to student_sections_url, notice: 'Student section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_section
      @student_section = StudentSection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_section_params
      params.fetch(:student_section, {})
    end
end
