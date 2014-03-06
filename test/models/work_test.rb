require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "work should not save with no associated user" do
    work = Work.first
    assert work.valid?
    work.user_id = nil
    assert_not work.valid?
  end

  test "work should not save with future date" do
    work = Work.first
    assert work.valid?, "work should be valid"
    work.date_time_performed = Date.today + 2.days
    assert work.invalid?, "work should be invalid"
    assert work.errors[:date_time_performed].any?, "work should have date time performed error"
  end
end
