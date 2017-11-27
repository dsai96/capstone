class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    @requirements = Requirement.all
    
    # set departments TODO: only do this once during seeding and store departments somewhere?
    @depts = []
    @courses.each do |c|
      dept = c.department
      unless @depts.include?(dept)
        @depts.push(dept)
      end
    end
    @depts.sort_by!{ |d| d.downcase }
    
    # order course-set by code + paginate
    @courses = @courses.by_code
    if (@courses.length > 20)
      @courses = @courses.paginate(:page => params[:courses]).per_page(20)
    end
  end
  
  def from_department
    @courses = Course.all
    @requirements = Requirement.all
    
    # Gathering all departments
    @depts = []
    @courses.each do |c|
      dept = c.department
      unless @depts.include?(dept)
        @depts.push(dept)
      end
    end
    @depts.sort_by!{ |d| d.downcase }
    
    # Obtaining ajax params
    @dept_name = params[:dept_name]
    @min_unit = params[:min_unit]
    @max_unit = params[:max_unit]
    @req_name = params[:req_name]
    
    # Filtering course-set according to ajax params
    unless @dept_name.nil? || (@dept_name == "all")
      @courses = @courses.for_department(@dept_name)
    end
    unless @min_unit.nil?
      @courses = @courses.min_units(@min_unit)
    end
    unless @max_unit.nil?
      @courses = @courses.max_units(@max_unit)
    end
    unless @req_name.nil? || (@req_name == "all")
      req_id = Requirement.find_by_name(@req_name).id
      @courses = @courses.for_requirement(req_id)
    end
    
    # order course-set by code + paginate
    @courses = @courses.by_code
    @courses = @courses.paginate(:page => params[:courses]).per_page(20)
    
    respond_to do |format|
      format.js
      format.json
      format.html
    end
  end
  
  def find_course
    code = params[:code]
    @courses = Course.for_code(code)
    respond_to do |format|
      format.js
    end
  end
  
  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :department, :units, :description, :mini)
    end
end
