#ActiveRecordBridge

> The goal of this project is to allow symantic relationships between multiple orms/databases.
> While it is generally not advised to use multiple storage methods if it can be avoided this handles
> the case when it can't be avoided or you have no choice.

Currently Supported ORMS:
* Mongoid

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
