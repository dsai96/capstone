require 'test_helper'

class CourseSemestersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_semester = course_semesters(:one)
  end

  test "should get index" do
    get course_semesters_url
    assert_response :success
  end

  test "should get new" do
    get new_course_semester_url
    assert_response :success
  end

  test "should create course_semester" do
    assert_difference('CourseSemester.count') do
      post course_semesters_url, params: { course_semester: { course_id: @course_semester.course_id, semester_id: @course_semester.semester_id } }
    end

    assert_redirected_to course_semester_url(CourseSemester.last)
  end

  test "should show course_semester" do
    get course_semester_url(@course_semester)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_semester_url(@course_semester)
    assert_response :success
  end

  test "should update course_semester" do
    patch course_semester_url(@course_semester), params: { course_semester: { course_id: @course_semester.course_id, semester_id: @course_semester.semester_id } }
    assert_redirected_to course_semester_url(@course_semester)
  end

  test "should destroy course_semester" do
    assert_difference('CourseSemester.count', -1) do
      delete course_semester_url(@course_semester)
    end

    assert_redirected_to course_semesters_url
  end
end
