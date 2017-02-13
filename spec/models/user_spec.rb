require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it {is_expected.to have_many(:todos) }
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:password)}
  end
end
