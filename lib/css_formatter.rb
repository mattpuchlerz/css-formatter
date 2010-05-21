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
    rules_from(css).map { |rule| format_rule rule }.join "\n\n"
  end
  
  private
  
  def format_property property
    pieces = property.split(':').map { |piece| piece.strip }
    ( options[:multiline] ? options[:indentation] : '' ) + pieces[0] + ': ' + pieces[1] + ';'    
  end
  
  def format_rule rule
    separator = options[:multiline] ? "\n" : ' '
    
    properties = properties_from rule
    properties.sort! if options[:alphabetize]
    properties.map! { |property| format_property property }
    
    selector_from(rule) + ' {' + separator + properties.join(separator) + separator + '}'
  end
  
  def properties_from rule
    rule.match( /.*\{(.+)\}.*/ )[1].split ';'
  end
  
  def rules_from css
    css.scan( /\s*([^\{]+\{.*?\})\s*/ ).flatten
  end
  
  def selector_from rule
    rule.match( /(.+)\s+\{/ )[1]
  end
  
end