# Factory
Implementation of 'Factory' class which has the same behavior as 'Struct' class.

## Usage
```
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
```