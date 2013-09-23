<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
              xmlns:xhtml="http://www.w3.org/1999/xhtml"
              xmlns:social="http://ef.gy/2012/social"
              xmlns:atom="http://www.w3.org/2005/Atom"
              xmlns:data="http://ef.gy/2013/data"
              xmlns:math="http://www.w3.org/1998/Math/MathML"
              xmlns="http://www.w3.org/1999/xhtml"
              exclude-result-prefixes="xhtml data"
              version="1.0">
  <xsl:output method="text" version="1.0" encoding="UTF-8" />

  <xsl:param name="year"/>
  <xsl:param name="constituency"/>

  <xsl:template match="text()"/>

  <xsl:template match="xhtml:table/xhtml:tbody/xhtml:tr[(xhtml:td[1] != 'Wahlberechtigte') and (xhtml:td[1] != 'Wähler') and (xhtml:td[1] != 'Gültige')]">
    <xsl:choose>
      <xsl:when test="(xhtml:td[2] != '-') and (xhtml:td[5] != '-')">insert into rawResult (year, constituency, party, primaryVote, secondaryVote) values (<xsl:value-of select="$year"/>, <xsl:value-of select="$constituency"/>, '<xsl:value-of select="xhtml:td[1]"/>', <xsl:value-of select="translate(xhtml:td[2],'.','')"/>, <xsl:value-of select="translate(xhtml:td[5],'.','')"/>);</xsl:when>
      <xsl:when test="xhtml:td[2] != '-'">insert into rawResult (year, constituency, party, primaryVote) values (<xsl:value-of select="$year"/>, <xsl:value-of select="$constituency"/>, '<xsl:value-of select="xhtml:td[1]"/>', <xsl:value-of select="translate(xhtml:td[2],'.','')"/>);</xsl:when>
      <xsl:when test="xhtml:td[5] != '-'">insert into rawResult (year, constituency, party, secondaryVote) values (<xsl:value-of select="$year"/>, <xsl:value-of select="$constituency"/>, '<xsl:value-of select="xhtml:td[1]"/>', <xsl:value-of select="translate(xhtml:td[5],'.','')"/>);</xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

