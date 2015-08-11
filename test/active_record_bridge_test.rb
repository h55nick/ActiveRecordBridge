require 'test_helper'

class ActiveRecordBridgeTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ActiveRecordBridge
  end
end
