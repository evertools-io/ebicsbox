require 'faker'

require_relative '../../box/models/organization'

I18n.reload!

Fabricator(:organization, from: 'Box::Organization') do
  name { Faker::Company.name }
end
