 module GenerateSlug
  extend ActiveSupport::Concern
    included do
      after_validation :generate_slug
      class_attribute :slug_attr
    end

    def generate_slug
      the_slug = self.send(slug_attr)
      self.slug = the_slug.gsub(/[^0-9a-z ]/i, '').strip.gsub(' ','-').downcase
    end
    def to_param
      self.slug
    end

    module ClassMethods
      def sluggable_column(col_name)
        self.slug_attr = col_name
      end
    end 

end