<xsl:stylesheet version="3.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		>
 <xsl:output xmlns:f="data,f" method="html" encoding="US-ASCII" version="5"
	     include-content-type="no"
	     exclude-result-prefixes="f"/>

 <xsl:variable name="max" select="//tbody/tr[position() gt 10][td[2]=''][1]/count(preceding-sibling::tr)+1"/>
 
 <xsl:template match="/">
  <html>
   <head>
    <title>Intent Examples</title>
    <meta charset="UTF-8"/>
    <style>
     .tex{font-family: monospace; width:15em}
     tbody th {width:2em;}
     math{font-size:120%;margin:.2em;}
     div.mathcat{
     background-color:white;padding:.2em;
     margin:-.2em .1em 1em .1em;
     }
     a.self {text-decoration:none;color:DarkBlue}
     a.self::visited  {text-decoration:none;color:DarkBlue}
    </style>
   </head>
   <body>
    <h1>Intent Examples</h1>

    <p><a href="https://docs.google.com/spreadsheets/d/1PhjYFEz3PhRTsE5U4RiPH84pnTTTwilh0wx-ujnprqg/edit#gid=0">Original Google Docs spreadsheet</a>.</p>
    <p><a href="intent1.html">List 2 (Deyan G)</a></p>
    <p><a href="intent1.html">List 3 (David C)</a></p>
    
    <p><xsl:copy-of select="//tbody/tr[1]/*[2]/node()"/></p>

    <table>
     <colgroup>
      <col style="background-color:beige"/>
      <col style="background-color:#EEE"/>
      <col style="background-color:#DDF;min-width:12em"/>
      <col style="background-color:#DFD;min-width:12em"/>
      <col style="background-color:#EEE; font-family:monospace;"/>
      <col style="background-color:beige"/>
      <col style="background-color:beige"/>
      </colgroup>
     <thead>
      <th> # </th>
      <th>TeX</th>
      <th>MathML</th>
      <th>MathML+intent</th>
      <th>MathML+intent Source</th>
      <th>English</th>
      <th>French</th>
     </thead>
     <xsl:for-each select="//tr[position() gt 5 and position() lt $max]">
      <tr>
       <xsl:sequence xmlns:f="data,f" select="f:nn(normalize-space(th[1]))"/>
       <td class="tex"><xsl:value-of select="td[1]"/></td>
       <td>
	<xsl:variable name="m" select="replace(replace(replace((td[2]),'&amp;lt;','&lt;'),'&amp;gt;','&gt;'),'&amp;quot;','&quot;')"/>
<!--	<xsl:message select="'&#10;[m]&#10;',$m"/>-->
<!--	<xsl:message select="'M',parse-xml-fragment($m)"/>-->
	<xsl:for-each select="parse-xml-fragment($m)/*">
	 <xsl:text>&#10;</xsl:text>
	 <math display="block">
	  <xsl:copy-of select="."/>
	  <xsl:text>&#10;</xsl:text>
	 </math>
	 <xsl:text>&#10;</xsl:text>
	</xsl:for-each>
       </td>
       <td>
	<xsl:variable name="m" select="replace(replace(replace((td[4]),'&amp;lt;','&lt;'),'&amp;gt;','&gt;'),'&amp;quot;','&quot;')"/>
<!--	<xsl:message select="'&#10;[K]&#10;',$m"/>-->
	<!--<xsl:message select="'I',parse-xml-fragment($m)"/>-->
	<xsl:for-each select="parse-xml-fragment($m)/*">
	 <xsl:text>&#10;</xsl:text>
	 <math display="block">
	  <xsl:copy-of select="."/>
	  <xsl:text>&#10;</xsl:text>
	 </math>
	 <xsl:text>&#10;</xsl:text>
	</xsl:for-each>
       </td>
	<td><pre><xsl:copy-of select="td[4]/node()"/></pre></td>
	<xsl:copy-of select="td[5]"/>
	<xsl:copy-of select="td[6]"/>
      </tr>
     </xsl:for-each>
    </table>
    <xsl:for-each select="//tr[position() ge $max]">
     <p><xsl:copy-of select="*[position()!=1]/node()"/></p>
    </xsl:for-each>

   </body>

  </html>
 </xsl:template>



<xsl:function xmlns:f="data,f" name="f:nn" as="element()">
 <xsl:param name="nn"/> 
 <xsl:element name="th">
  <xsl:attribute name="id" select="concat('id',$nn)"/>
  <xsl:element name="a">
   <xsl:attribute name="href" select="concat('#id',$nn)"/>
   <xsl:attribute name="class" select="'self'"/>
   <xsl:value-of select="$nn"/>
  </xsl:element>
 </xsl:element>
</xsl:function>


</xsl:stylesheet>
