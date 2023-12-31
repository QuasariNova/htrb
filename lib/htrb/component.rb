module HTRB
  class Component < HtmlNode
    def self.inherited(subclass)
      sym = ('_' + subclass.name.downcase.split('::').last + '!').to_sym

      raise TagExistsError.new sym if HtmlNode.private_method_defined? sym

      HtmlNode.send :define_method, sym do |**attributes, &contents|
        append subclass.new(**attributes, &contents)
      end
      HtmlNode.send :private, sym
    end

    def self_closing?
      true
    end
  end
end
