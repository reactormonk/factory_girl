class Factory
  class Proxy #:nodoc:
    class ValidationError < RuntimeError
    end
    class Create < Build #:nodoc:
      def result
        unless @instance.save #changed from #save! because DM and AR differ in thier defination
          raise ValidationError, "Factory Girl could not validate created instance: #{@instance.inspect}"
        end
        @instance
      end
    end
  end
end
