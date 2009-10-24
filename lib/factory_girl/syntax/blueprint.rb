class Factory
  module Syntax

    # Extends ActiveRecord::Base and/or DataMapper::Model to provide a make
    # class method, which is an alternate syntax for defining factories.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/blueprint'
    #
    #   User.blueprint do
    #     name  { 'Billy Bob'             }
    #     email { 'billy@bob.example.com' }
    #   end
    #
    #   Factory(:user, :name => 'Johnny')
    #
    # This syntax was derived from Pete Yandell's machinist.
    module Blueprint
      module ModelInclude #:nodoc:

        def self.included(base) # :nodoc:
          base.extend ClassMethods
        end

        module ClassMethods #:nodoc:

          def blueprint(&block)
            instance = Factory.new(name.underscore, :class => self)
            instance.instance_eval(&block)
            Factory.factories[instance.factory_name] = instance
          end

        end

      end
    end
  end
end

ar_class = Module.const_get('ActiveRecord').const_get('Base') rescue nil
ar_class.send(:include, Factory::Syntax::Blueprint::ModelInclude) if ar_class

dm_class = Module.const_get('DataMapper').const_get('Model') rescue nil
dm_class.send(:append_inclusions, Factory::Syntax::Blueprint::ModelInclude) if dm_class
