require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validation' do
    it {is_expected.to belong_to(:user) }
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_inclusion_of(:done).in_array([true,false])}
  end
end
