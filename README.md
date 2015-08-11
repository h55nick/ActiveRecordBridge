#ActiveRecordBridge



## EXAMPLES

Active Record Classes:
```ruby
class Property < ActiveRecord::Base
#   ...
   has_many_documents :default_rules
   has_one_document :address
#   ...
end
```
----
Mongoid Classes:
```ruby
class Rule
  include Mongoid::Document
  include ActiveRecordBridge::Mongoid
#   ...
  belongs_to_record :property
  belongs_to_record :updated_by, class_name: 'User'
  belongs_to_record :approved_by, class_name: 'User'
#   ...
end
```

This project rocks and uses MIT-LICENSE.
