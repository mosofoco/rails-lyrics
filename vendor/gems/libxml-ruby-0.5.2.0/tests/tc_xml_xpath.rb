# $Id: tc_xml_xpath.rb 183 2007-09-21 14:09:52Z danj $
require "libxml_test"
require "test/unit"

class TC_XML_XPath < Test::Unit::TestCase
  def setup()
    xp = XML::Parser.new()
    str = '<ruby_array uga="booga" foo="bar"><fixnum>one</fixnum><fixnum>two</fixnum></ruby_array>'
    assert_equal(str, xp.string = str)
    doc = xp.parse
    assert_instance_of(XML::Document, doc)
    @xpt = doc.find('/ruby_array/fixnum')
    assert_instance_of(XML::XPath::Object, @xpt)
  end

  def teardown()
    @xpt = nil
  end

  def test_libxml_xpath_set()
    set = @xpt.set
    assert_instance_of(XML::Node::Set, set)    
  end
end # TC_XML_Document