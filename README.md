# Factory
Implementation of 'Factory' class which has the same behavior as 'Struct' class.

## Usage
```
Customer = Factory.new(:name, :address) do
  def greeting
    "Hello #{name} from block!"
  end
end
object = Customer.new("Dave", "123 Main")
object.greeting               # "Hello Dave from block!"
object.name                   # "Dave"
object.name = nil             # nil
object.name?                  # false
object.class                  # Customer
object2 = Customer.new("Dave", "123 Main")
p object == object2           # true
```