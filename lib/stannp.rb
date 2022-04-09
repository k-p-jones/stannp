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
  # objects
  autoload :User, 'stannp/objects/user'
  autoload :Recipient, 'stannp/objects/recipient'
  autoload :Account, 'stannp/objects/account'
end
