class Factory
  module Syntax

    # Extends ActiveRecord::Base and/or DataMapper::Model to provide a make
    # class method, which is a shortcut for Factory.create.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/make'
    #   
    #   Factory.define :user do |factory|
    #     factory.name 'Billy Bob'
    #     factory.email 'billy@bob.example.com'
    #   end
    #
    #   User.make(:name => 'Johnny')
    #
    # This syntax was derived from Pete Yandell's machinist.
    module Make
      module ModelInclude #:nodoc:

        def self.included(base) # :nodoc:
          base.extend ClassMethods
        end

        module ClassMethods #:nodoc:

          def make(overrides = {})
            Factory.create(name.underscore, overrides)
          end

        end

      end
    end
  end
end

ar_class = Module.const_get('ActiveRecord').const_get('Base') rescue nil
ar_class.send(:include, Factory::Syntax::Make::ModelInclude) if ar_class

dm_class = Module.const_get('DataMapper').const_get('Model') rescue nil
dm_class.send(:append_inclusions, Factory::Syntax::Make::ModelInclude) if dm_class
