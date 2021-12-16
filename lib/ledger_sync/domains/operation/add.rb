# frozen_string_literal: true

require_relative '../operation'
require_relative 'resource'

module LedgerSync
  module Domains
    class Operation
      class Add < Resource
        private

        def operate
          if resource.save
            success
          else
            failure(
              'Please review the problems below:',
              data: serialize(resource: resource)
            )
          end
        end

        def resource
          @resource ||= resource_class.new(params)
        end

        def success
          super(
            serialize(resource: resource)
          )
        end

        def failure(message, data: nil)
          super(
              LedgerSync::Error::OperationError.new(
                operation: self,
                message: message,
                response: data
              )
          )
        end
      end
    end
  end
end
