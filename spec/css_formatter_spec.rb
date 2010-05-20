require File.dirname(__FILE__) + '/spec_helper'

describe CSSFormatter do
  
  describe "default options" do
    
    before :each do
      @formatter = CSSFormatter.new
    end
    
    it "has an indentation option" do
      @formatter.options[:indentation].should == '  '
    end
    
    it "has a multiline option" do
      @formatter.options[:multiline].should be_true
    end
    
    it "has an alphabetize option" do
      @formatter.options[:alphabetize].should be_true
    end
    
  end
  
  context "when initialized with options" do
    
    it "overwrites the default indentation option" do
      formatter = CSSFormatter.new :indentation => "\t"
      formatter.options[:indentation].should == "\t"
    end
    
  end
  
  context "when formatting CSS" do
    
    before :each do
      @formatter = CSSFormatter.new
      @css1 = %| p {width:450px;height:200px;padding:0px} |
      @css2 = %| .right50 { float: right; width: 49.5% } |
      @css3 = %| #header {background:#ccc;color:#c00;} |
      @css_all = [ @css1, @css2, @css3 ].join "\n" 
    end
    
    it "should format the passed CSS string" do
      @formatter.format(@css1).should == %|p {
  height: 200px;
  padding: 0px;
  width: 450px;
}|
    end
    
    it "should also format this CSS string" do
      @formatter.format(@css2).should == %|.right50 {
  float: right;
  width: 49.5%;
}|
    end
    
  end
  
end