module Pipedrive
  class Organization < Base

    class << self

      def find_or_create_by_name(name, opts={})
        find_by_name(name).first || create(opts.merge(:title => name))
      end

    end
  end
end