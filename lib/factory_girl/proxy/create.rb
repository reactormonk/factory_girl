class Factory
  class Proxy #:nodoc:
    class ValidationError < RuntimeError
    end
    class Create < Build #:nodoc:
      def result
        run_callbacks(:after_build)
        unless @instance.save #changed from #save! because DM and AR differ in thier defination
          raise ValidationError, "Factory Girl could not validate created instance: #{@instance.inspect}"
        end
        run_callbacks(:after_create)
      end
    end
  end
end
