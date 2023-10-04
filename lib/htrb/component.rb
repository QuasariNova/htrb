module HTRB
  class Component < HtmlNode
    def self.inherited(subclass)
      sym = ('_' + subclass.name.downcase.split('::').last).to_sym

      raise TagExistsError.new sym if HtmlNode.method_defined? sym

      HtmlNode.send :define_method, sym do |**attributes, &contents|
        child subclass.new(**attributes, &contents)
      end
    end
  end
end
