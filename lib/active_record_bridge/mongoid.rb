puts "[ActiveRecordModelBridge] Bridge between ActiveRecord and mongoid intialized (#{__FILE__})".yellow

## EXAMPLE ##
# class Property < ActiveRecord::Base
#   ...
#   has_many_documents :default_rules
#   has_one_document :address
#   ...
# end
# class Rule
#   include Mongoid::Document
#   include Mongoid::ActiveRecordBridge
#   ...
#   belongs_to_record :property
#   belongs_to_record :updated_by, class_name: 'User'
#   belongs_to_record :approved_by, class_name: 'User'
#   ...
# end
#

# Original source: http://hashrocket.com/blog/posts/bridging-activerecord-and-mongoid
# => https://gist.github.com/jponc/0fbaf4b5aa4ad7cafa9e

module ActiveRecordBridge
  module Mongoid
    extend ActiveSupport::Concern

    included do
      def self.belongs_to_record(association_name, options={})
        association_class = options[:class_name] || association_name.to_s.singularize.classify
        class_eval %<
        field :#{association_name}_id, type: Integer
        index(#{association_name}_id: 1)

        def #{association_name}
          @#{association_name} ||= #{association_class}.find(#{association_name}_id)
        end

        def #{association_name}=(object)
          self.#{association_name}_id = object.try :id
          @#{association_name} = object
        end
        >
      end
    end
  end
end
