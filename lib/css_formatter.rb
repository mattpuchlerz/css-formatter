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
    rules = css.gsub("\n", '').split('}').reject { |r| r =~ /^\s+$/ }.map do |rule|
      
      rule = rule.strip + '}'
    
      selector = rule.match(/(.+)\s+\{/)[1]
    
      properties = rule.
        match(/.*\{(.+)\}.*/)[1].
        split(';').
        sort.
        map do |property| 
          pieces = property.split(':').map { |piece| piece.strip }
          "#{ options[:indentation] }#{ pieces[0] }: #{ pieces[1] };"
        end
      
      "#{ selector } {\n#{ properties.join "\n" }\n}"
      
    end.join "\n\n"
  end
  
end