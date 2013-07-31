module Includable
  module AsJson
    extend ActiveSupport::Concern

    included do

      define_singleton_method :expose_attrs do |attrs|
        define_method :as_json_options do |options|
          # val must be array!
          preset_options = attrs
          if defined?(super)
            super(preset_options).each do |key,val|
              if options.has_key?(key)
                options[key] = (val.to_set.merge options[key]).to_a
              else
                options[key] = val
              end
            end
          else
            preset_options.each do |key,val|
              if options.has_key?(key)
                options[key] = (val.to_set.merge options[key]).to_a
              else
                options[key] = val
              end
            end
          end
          options
        end

        define_method :as_json do |options={}|
          super as_json_options(options)
        end
      end # after define_singleton_method

    end


  end
end