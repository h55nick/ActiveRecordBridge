class ActiveRecordBridgeError < Exception ; end

module MongoidBridge
  def self.has_many_documents(association_name)
    class_eval %<
      def #{association_name}
        #{association_name.to_s.singularize.classify}.where(#{name.underscore}_id: id)
      end
    >
  end

  def self.belongs_to_document(association_name, options={})
    association_class = options[:class_name] || association_name.to_s.singularize.classify
    class_eval %<
      def #{association_name}
        #{association_class}.find(#{association_name}_id)
      end

      def #{association_name}=(relation)
        update_attribute('#{association_name}_id', relation.try(:id))
      end

      def create_#{association_name} (new_attributes = {})
        #{association_class}.create(new_attributes.merge(#{name.underscore}_id: id))
      end
    >
  end

  def self.has_one_document(association_name, options={})
    association_class = options[:class_name] || association_name.to_s.singularize.classify
    klass_name = self.name.underscore
    class_eval %<
      after_create :sync_#{association_name}

      def #{association_name}
        @#{association_name} ||= #{association_class}.find_by(#{klass_name}_id: self.id)
      end

      def #{association_name}=(relation)
        relation.#{klass_name}_id = self.id
        relation.#{klass_name} = self
        @#{association_name} = relation
      end

      def create_#{association_name} (new_attributes = {})
        #{association_class}.create(new_attributes.merge(#{klass_name}_id: id))
      end

      def #{association_name}_id
        #{association_name}.try :id
      end

      def #{association_name}_id=(id)
        raise ActiveRecordBridgeError, "has_one relationships do not have _id here. Go to the belongs_to side."
      end

      def sync_#{association_name}
        @#{association_name}.update_attribute(:#{klass_name}_id, self.id) if @#{association_name}
      end
    >
  end
end

ActiveRecord::Base.extend ActiveRecordBridge::MongoidBridge
