require 'test/test_helper'

class RoleTest < ActiveSupport::TestCase
  def test_valid_fields
    role = roles(:valid_admin_role)
    assert role.valid?
  end

end
