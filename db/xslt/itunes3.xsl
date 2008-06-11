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
      <xsl:element name="title">
        <xsl:value-of select="key[.='Name']/following-sibling::node()[1]"/>
      </xsl:element>
      <xsl:call-template name="artist" />
      <xsl:call-template name="album" />
      <xsl:call-template name="genre" />
      <xsl:call-template name="year" />
      <xsl:call-template name="track_number" />
      <xsl:call-template name="file_loc" />
    </xsl:element>
  </xsl:template>

  <xsl:template name="artist">
    <xsl:element name="artist">
        <xsl:value-of select="key[.='Artist']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="album">
      <xsl:element name="album">
        <xsl:value-of select="key[.='Album']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="genre">
    <xsl:element name="genre">
       <xsl:value-of select="key[.='Genre']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="year">
    <xsl:element name="year">
        <xsl:value-of select="key[.='Year']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="track_number">
    <xsl:element name="track_number">
        <xsl:value-of select="key[.='Track Number']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template name="file_loc">
    <xsl:element name="file_loc">
        <xsl:value-of select="key[.='Location']/following-sibling::node()[1]"/>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>