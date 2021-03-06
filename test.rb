require "./factory"

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
p object[:name]                 # "Dave"
p object["name"]                # "Dave"
p object[0]                     # "Dave"
p object.name = nil             # nil
p object.name?                  # false
p object.name = "Dave"          # "Dave"
p object.name?                  # true
p object.class                  # Customer

object2 = Customer.new("Dave", "123 Main")
p object == object2