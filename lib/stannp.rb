# frozen_string_literal: true

require_relative 'stannp/version'

module Stannp
  autoload :Error, 'stannp/error'
  autoload :Client, 'stannp/client'
  autoload :Resource, 'stannp/resource'
  autoload :Object, 'stannp/object'
  autoload :List, 'stannp/list'
  # resources
  autoload :AccountResource, 'stannp/resources/account'
  autoload :UserResource, 'stannp/resources/user'
  autoload :RecipientsResource, 'stannp/resources/recipients'
  autoload :AddressesResource, 'stannp/resources/addresses'
  autoload :PostcardsResource, 'stannp/resources/postcards'
  autoload :LettersResource, 'stannp/resources/letters'
  # objects
  autoload :User, 'stannp/objects/user'
  autoload :Recipient, 'stannp/objects/recipient'
  autoload :Receipt, 'stannp/objects/receipt'
  autoload :Postcard, 'stannp/objects/postcard'
  autoload :Letter, 'stannp/objects/letter'
  autoload :Batch, 'stannp/objects/batch'
end
