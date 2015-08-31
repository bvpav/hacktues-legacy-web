require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "HackTUES"
    assert_equal full_title("Foo"), "Foo | HackTUES"
  end
end
