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
          args.inject { |eql, var| eql && ( self.send("#{var}") == other.send("#{var}") ) }
        end

        def initialize(*values)
          @@attributes.each_with_index { |attr, i| send("#{attr}=", values[i]) }
        end

        class_eval(&block) if block
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

puts "Creating class with block 'Customer.new('Dave', '123 Main').greeting':"
Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name} from block!"
  end
end
object = Customer.new("Dave", "123 Main")
p object.greeting               # "Hello Dave from block!"
p object.name                   # "Dave"
p object.name = nil             # nil
p object.name?                  # false
p object.class                  # Customer

object2 = Customer.new("Dave", "123 Main")
p object == object2
