/* $Id: ruby_xml_xinclude.c 134 2007-08-29 17:30:19Z danj $ */

/* Please see the LICENSE file for copyright and distribution information */

#include "libxml.h"
#include "ruby_xml_xinclude.h"

VALUE cXMLXInclude;
VALUE eXMLXIncludeError;

// Rdoc needs to know 
#ifdef RDOC_NEVER_DEFINED
  mXML = rb_define_module("XML");
#endif

void
ruby_init_xml_xinclude(void) {
  cXMLXInclude = rb_define_class_under(mXML, "XInclude", rb_cObject);
  eXMLXIncludeError = rb_define_class_under(cXMLXInclude, "Error", rb_eRuntimeError);
}
