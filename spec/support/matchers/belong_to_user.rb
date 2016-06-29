RSpec::Matchers.define :belong_to_user do |expected|
  match do |actual|
    actual.user == expected
  end
end
