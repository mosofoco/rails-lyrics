/* $Id: ruby_xml_xpointer_context.h 134 2007-08-29 17:30:19Z danj $ */

/* Please see the LICENSE file for copyright and distribution information */

#ifndef __RUBY_XML_XPOINTER_CONTEXT__
#define __RUBY_XML_XPOINTER_CONTEXT__

extern VALUE cXMLXPointerContext;
extern VALUE eXMLXPointerContextInvalidPath;

typedef struct ruby_xml_xpointer_context {
  VALUE xd;
  xmlXPathContextPtr ctxt;
} ruby_xml_xpointer_context;

void ruby_init_xml_xpointer_context(void);

#endif
