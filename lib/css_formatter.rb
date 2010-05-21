class CSSFormatter
  
  attr_reader :options
  
  def initialize options = {}
    @options = {
      :alphabetize => true,
      :indentation => '  ',
      :multiline   => true
    }.merge options
  end
  
  def format css
    separator = options[:multiline] ? "\n" : ' '
    
    rules_from(css).map do |rule|
      
      properties = properties_from rule
      properties.sort! if options[:alphabetize]
      
      properties.map! do |property| 
        pieces = property.split(':').map { |piece| piece.strip }
        "#{ options[:indentation] if options[:multiline] }#{ pieces[0] }: #{ pieces[1] };"
      end
      
      selector_from(rule) + ' {' + separator + properties.join(separator) + separator + '}'
      
    end.join "\n\n"
  end
  
  private
  
  def rules_from css
    css.scan( /\s*([^\{]+\{.*?\})\s*/ ).flatten
  end
  
  def properties_from rule
    rule.match( /.*\{(.+)\}.*/ )[1].split ';'
  end
  
  def selector_from rule
    rule.match( /(.+)\s+\{/ )[1]
  end
  
end