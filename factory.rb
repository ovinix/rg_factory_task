class Factory
  def self.new(*args, &block)
      Class.new do
        @@attributes = args

        args.each do |arg|
          define_method "#{arg}" do
            instance_variable_get("@#{arg}")
          end

          define_method "#{arg}=" do |value|
            instance_variable_set("@#{arg}", value)
          end

          define_method "#{arg}?" do
            !!send("#{arg}")
          end
        end

        define_method "==" do |other|
          args.inject { |eql, attr| eql && ( self.send("#{attr}") == other.send("#{attr}") ) }
        end

        define_method "[]" do |attr|
          if attr.is_a? Fixnum
            send("#{args[attr]}")
          else
            send("#{attr}")
          end
        end

        define_method "[]=" do |attr, value|
          if attr.is_a? Fixnum
            send("#{args[attr]}=", value)
          else
            send("#{attr}=", value)
          end
        end

        def initialize(*values)
          @@attributes.each_with_index { |attr, i| send("#{attr}=", values[i]) }
        end

        class_eval(&block) if block
      end
  end
end
