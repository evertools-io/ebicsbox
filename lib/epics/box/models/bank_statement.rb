require 'securerandom'
require 'sequel'

module Epics
  module Box
    class BankStatement < Sequel::Model
      self.raise_on_save_failure = true

      many_to_one :account
      one_to_many :statements
    end
  end
end
