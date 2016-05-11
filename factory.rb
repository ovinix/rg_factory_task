class Factory
  def self.new(*args)
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

        def initialize(*values)
          @@attributes.each_with_index { |attr, i| send("#{attr}=", values[i]) }
        end
      end
  end
end

puts "Creating class with attributes: MyClass = Factory.new(:one, :two)"

MyClass = Factory.new(:one, :two)

puts "MyClass respond to 'new': #{MyClass.respond_to?(:new)}"

puts "Creating object: o = MyClass.new('one')"
o = MyClass.new("one")

puts "Object class: #{o.class}"
puts "Object instance variables: #{o.instance_variables}"
print "Object inspect: "
p o
puts "Object methods for instance variables: #{o.methods.sort.grep /^(one|two)/}"
print "Result for 'o.one': "
p o.one
print "Result for 'o.one = nil': "
p o.one = nil
print "Result for 'o.one?': "
p o.one?
print "Result for 'o.two': "
p o.two
print "Result for 'o.two = 'two': "
p o.two = 'two'
print "Result for 'o.two?: "
p o.two?
