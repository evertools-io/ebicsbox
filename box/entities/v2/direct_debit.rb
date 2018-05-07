require 'grape-entity'
require_relative './transaction'

module Box
  module Entities
    module V2
      class DirectDebit < Grape::Entity
        expose(:public_id, as: "id")
        expose(:account) { |transaction| transaction.account.iban }
        expose(:name) { |trx| trx.parsed_payload[:payments].first[:transactions].first[:name] }
        expose(:iban) { |trx| trx.parsed_payload[:payments].first[:transactions].first[:iban] }
        expose(:bic) { |trx| trx.parsed_payload[:payments].first[:transactions].first[:bic] }
        expose(:amount, as: "amount_in_cents")
        expose(:eref, as: 'end_to_end_reference')
        expose(:reference) { |trx| trx.parsed_payload[:payments].first[:transactions].first[:remittance_information] }
        expose(:collection_date) { |trx| trx.parsed_payload[:payments].first[:collection_date] }
        expose(:status)
        expose(:_links) do |transaction|
          iban = transaction.account.iban
          {
            self: Box.configuration.app_url + "/direct_debits/#{transaction.id}",
            account: Box.configuration.app_url + "/accounts/#{iban}/",
          }
        end
      end
    end
  end
end
