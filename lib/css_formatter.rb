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
    css.strip!
    
    selector = css.match(/(.+)\s+\{/)[1]
    
    properties = css.
      match(/.*\{(.+)\}.*/)[1].
      split(';').
      sort.
      map { |p| p.sub /(.+):(.+)/, (options[:indentation] + '\1: \2;') }
    
    "#{ selector } {\n#{ properties.join "\n" }\n}"
  end
  
end