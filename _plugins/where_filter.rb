module Jekyll
  module WhereFilter
    def filter_on(collection, key, value)
      collection.select do |e|
        e = e.call if e.is_a?(Proc)
        e.respond_to?(:[])
        e[key] == value
      end
    end
  end
end
Liquid::Template.register_filter(Jekyll::WhereFilter)
