class Factory
  module Syntax

    # Extends ActiveRecord::Base and/or DataMapper::Model to provide generation
    # methods for factories.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/generate'
    #
    #   Factory.define :user do |factory|
    #     factory.name 'Billy Bob'
    #     factory.email 'billy@bob.example.com'
    #   end
    #
    #   # Creates a saved instance without raising (same as saving the result
    #   # of Factory.build)
    #   User.generate(:name => 'Johnny')
    #
    #   # Creates a saved instance and raises when invalid (same as
    #   # Factory.create)
    #   User.generate!
    #
    #   # Creates an unsaved instance (same as Factory.build)
    #   User.spawn
    #
    #   # Creates an instance and yields it to the passed block
    #   User.generate do |user|
    #     # ...do something with user...
    #   end
    #
    # This syntax was derived from Rick Bradley and Yossef Mendelssohn's
    # object_daddy.
    module Generate
      module ModelInclude #:nodoc:

        def self.included(base) # :nodoc:
          base.extend ClassMethods
        end

        module ClassMethods #:nodoc:

          def generate(overrides = {}, &block)
            instance = Factory.build(name.underscore, overrides)
            instance.save
            yield(instance) if block_given?
            instance
          end

          def generate!(overrides = {}, &block)
            instance = Factory.create(name.underscore, overrides)
            yield(instance) if block_given?
            instance
          end

          def spawn(overrides = {}, &block)
            instance = Factory.build(name.underscore, overrides)
            yield(instance) if block_given?
            instance
          end

        end

      end
    end
  end
end

ar_class = Module.const_get('ActiveRecord').const_get('Base') rescue nil
ar_class.send(:include, Factory::Syntax::Generate::ModelInclude) if ar_class

dm_class = Module.const_get('DataMapper').const_get('Model') rescue nil
dm_class.send(:include, Factory::Syntax::Generate::ModelInclude) if dm_class
