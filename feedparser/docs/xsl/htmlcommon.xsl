<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version='1.0'>
  
  <!--  exclude-result-prefixes="#default">-->

<xsl:import href="common.xsl"/>

<xsl:param name="html.stylesheet">feedparser.css</xsl:param>
<xsl:param name="admon.style"/>
<xsl:param name="css.decoration">0</xsl:param>
<xsl:param name="admon.graphics" select="1"/>
<xsl:param name="callout.graphics" select="1"/>
<xsl:param name="spacing.paras" select="0"/>

<!-- suppress line on title page -->
<xsl:template name="book.titlepage.separator"/>

<!-- suppress attributes on body tag -->
<xsl:template name="body.attributes"/>

<!-- use real header tags for example titles -->
<xsl:template name="formal.object.heading">
  <xsl:param name="object" select="."/>
  <h3 class="title">
    <xsl:apply-templates select="$object" mode="object.title.markup">
      <xsl:with-param name="allow-anchors" select="1"/>
    </xsl:apply-templates>
  </h3>
</xsl:template>

<xsl:template name="navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <td id="breadcrumb" colspan="5" align="left">
    <xsl:text>&#160;</xsl:text>
  </td>
  <td id="navigation" align="right">
    <xsl:text>&#160;</xsl:text>
  </td>
</xsl:template>

<xsl:template name="logo">
  <h1 id="logo">
    <a href="index.html" accesskey="1"><xsl:value-of select="/book/bookinfo/title"/></a>
  </h1>
</xsl:template>

<xsl:template name="tagline">
  <p id="tagline">
    <xsl:value-of select="//subtitle"/>
  </p>
</xsl:template>

<!--
Behavior:    callout text overlaps callout graphic
Environment: Netscape 6
Workaround:  specify width of callout graphic <td> in absolute pixels to match image width
-->
<xsl:template match="callout">
  <tr>
    <td width="12" valign="top" align="left">
      <xsl:call-template name="callout.arearefs">
        <xsl:with-param name="arearefs" select="@arearefs"/>
      </xsl:call-template>
    </td>
    <td valign="top" align="left">
      <xsl:apply-templates/>
    </td>
  </tr>
</xsl:template>

<xsl:template match="acronym|abbrev">
  <xsl:param name="content">
    <xsl:call-template name="anchor"/>
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <acronym>
    <xsl:if test="@dir">
      <xsl:attribute name="dir">
        <xsl:value-of select="@dir"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="@condition">
      <xsl:attribute name="title">
        <xsl:value-of select="@condition"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </acronym>
</xsl:template>

</xsl:stylesheet>
