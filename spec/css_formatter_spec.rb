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
      @rule1 = %| p {width:450px;height:200px;padding:0px} |
      @rule2 = %| .right50 { float: right; width: 49.5% } |
      @rule3 = %| body.home #header > div {background:#ccc;color:#c00;} |
      @rules = [ @rule1, @rule2, @rule3 ].join "\n" 
    end
    
    it "should format the passed CSS string" do
      @formatter.format(@rule1).should == %|p {
  height: 200px;
  padding: 0px;
  width: 450px;
}|
    end
    
    it "should format a second CSS string" do
      @formatter.format(@rule2).should == %|.right50 {
  float: right;
  width: 49.5%;
}|
    end
    
    it "should format a third CSS string" do
      @formatter.format(@rule3).should == %|body.home #header > div {
  background: #ccc;
  color: #c00;
}|      
    end
    
    it "should format CSS strings with multiple rules" do
      @formatter.format(@rules).should == %|p {
  height: 200px;
  padding: 0px;
  width: 450px;
}

.right50 {
  float: right;
  width: 49.5%;
}

body.home #header > div {
  background: #ccc;
  color: #c00;
}|
    end
    
    context "with a different indentation" do
      
      before :each do
        @formatter = CSSFormatter.new :indentation => "\t"
      end
      
      it "should format the passed CSS string" do
        @formatter.format(@rule1).should == %|p {
\theight: 200px;
\tpadding: 0px;
\twidth: 450px;
}|
      end
      
    end
    
    context "with no alphabetization" do
      
      before :each do
        @formatter = CSSFormatter.new :alphabetize => false
      end
      
      it "should format the passed CSS string" do
        @formatter.format(@rule1).should == %|p {
  width: 450px;
  height: 200px;
  padding: 0px;
}|
      end
      
    end
    
    context "as single-line" do
      
      before :each do
        @formatter = CSSFormatter.new :multiline => false
      end
      
      it "should format the passed CSS string" do
        @formatter.format(@rule1).should == %|p { height: 200px; padding: 0px; width: 450px; }|
      end
      
    end
    
  end
  
end