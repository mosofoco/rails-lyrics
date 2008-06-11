<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" 
  version="1.0"
  encoding="iso-8859-1" 
  indent="yes" />

  <xsl:template match="/">
    <xsl:element name="library">
      <xsl:attribute name="value">
        <xsl:value-of select="'My iTunes Library'" />
      </xsl:attribute>
      <xsl:apply-templates select="plist/dict/dict/dict"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="plist/dict/dict/dict">
    <xsl:element name="track">
      <xsl:attribute name="value">
        <xsl:value-of select="key[.='Name']/following-sibling::node()[1]"/>
      </xsl:attribute>
      <xsl:call-template name="artist" />
      <xsl:call-template name="album" />
    </xsl:element>
  </xsl:template>

  <xsl:template name="artist">
    <xsl:element name="artist">
      <xsl:attribute name="value">
        <xsl:value-of select="key[.='Artist']/following-sibling::node()[1]"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:template name="album">
    <xsl:element name="album">
      <xsl:attribute name="value">
        <xsl:value-of select="key[.='Album']/following-sibling::node()[1]"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>