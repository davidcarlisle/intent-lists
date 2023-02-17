<xsl:stylesheet version="3.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		>
 <xsl:output xmlns:f="data,f" method="html" encoding="US-ASCII" version="5"
	     include-content-type="no"
	     exclude-result-prefixes="f"/>

 
 <xsl:template match="/">
  <html>
   <head>
    <title>Intent Examples (Deyan/Core Sheet)</title>
    <meta charset="UTF-8"/>
    <style>
     .tex{font-family: monospace; width:15em}
     tbody th {width:2em;}
     math{font-size:120%;margin:.2em;}
     mfrac[numalign="left"] >*:first-child {margin-right:90%;}
     div.mathcat{
     background-color:white;padding:.2em;
     margin:-.2em .1em 1em .1em;
     }
     a.self {text-decoration:none;color:DarkBlue}
     a.self::visited  {text-decoration:none;color:DarkBlue}
    </style>
   </head>
   <body>
    <h1>Intent Examples (Deyan/Core Sheet)</h1>
    <p><a href="https://docs.google.com/spreadsheets/d/1EsWou1K5nxBdLPvQapdoA9h-s8lg_qjn8fJH64g9izQ/edit#gid=1358098730">Original Google Docs spreadsheet</a>.</p>
    <p><a href="intent1.html">Other list</a></p>
    
    <table>
     <colgroup>
      <col style="background-color:beige"/>
      <col style="background-color:#DFD"/>
      <col style="background-color:beige;"/>
      <col style="background-color:beige"/>
      <col style="background-color:#EEE; font-family:monospace;"/>
      <col style="background-color:#DFD;min-width:12em"/>
      <col style="background-color:#DDF;min-width:12em"/>
      <col style="background-color:beige"/>
      </colgroup>     
     <thead>
      <th> # </th>
      <th>intent</th>
      <th>form</th>
      <th>example</th>
      <th>MathML+intent Source</th>
      <th>MathML+intent</th>
      <th>MathML</th>
      <th>Speech Hints</th>
     </thead>
     <xsl:for-each select="//tbody/tr[position() gt 2][not(*[2]='' and *[5]='')]">
      <xsl:variable name="nn"  select="normalize-space(*[1])"/>
      <xsl:variable name="intent" select="replace(
					  if(*[2]/node())
					  then normalize-space(*[2])
					  else normalize-space((preceding-sibling::tr/*[2][string()])[last()])
					  ,'\?.*','')
					  "/>
      <xsl:variable name="form" select="normalize-space(*[4])"/>
      <xsl:choose>
       <xsl:when test="$intent='annotation'">
	<tr>
	 <xsl:sequence xmlns:f="data,f" select="f:nn(concat($nn,'-1'))"/>
	 <td><xsl:value-of select="$intent"/></td>
	 <td>munder</td>
	 <td>munder</td>
<xsl:variable name="m" xml:space="preserve">
<munder intent="{$intent}">
 <munder>
  <mi>x</mi>
  <mo>&#x23DF;</mo>
 </munder>
 <mi>y</mi>
</munder>
</xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="*[7]/node()"/></td>
	  </tr>
	  <tr>
	   <xsl:sequence xmlns:f="data,f" select="f:nn(concat($nn,'-2'))"/>
	   <td><xsl:value-of select="$intent"/></td>
	   <td>mover</td>
	   <td>mover</td>
<xsl:variable name="m" xml:space="preserve">
<mover intent="{$intent}">
 <mover>
  <mi>x</mi>
  <mo>&#x23DE;</mo>
 </mover>
 <mi>y</mi>
</mover>
</xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="*[7]/node()"/></td>
	  </tr>
       </xsl:when>
       <xsl:when test="$form='infixprefix'">
	<xsl:variable name="example" select="*[5]/node()"/>
	  <tr>
	   <xsl:sequence xmlns:f="data,f" select="f:nn(concat($nn,'-1'))"/>
	   <td><xsl:value-of select="$intent"/></td>
	   <td>infix</td>
	   <td>infix</td>
<xsl:variable name="m" xml:space="preserve">
<mrow>
 <mi>x</mi>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mi>y</mi>
</mrow>
</xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="*[7]/node()"/></td>
	  </tr>
	  <tr>
	   <xsl:sequence xmlns:f="data,f" select="f:nn(concat($nn,'-2'))"/>
	   <td><xsl:value-of select="$intent"/></td>
	   <td>prefix</td>
	   <td>prefix</td>
<xsl:variable name="m" xml:space="preserve">
<mrow>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mi>x</mi>
</mrow>
</xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="*[7]/node()"/></td>
	  </tr>
       </xsl:when>       
       <xsl:when test="*[5]/br">
	<xsl:for-each-group group-adjacent="exists(self::br)" select="*[5]/node()">
	 <xsl:if test="not(self::br)">
	  <tr>
	   <xsl:sequence xmlns:f="data,f" select="f:nn(concat($nn,'-',count(preceding-sibling::br)+1))"/>
	   <td><xsl:value-of select="$intent"/></td>
	   <td><xsl:copy-of select="*[4]"/></td>
	   <td><xsl:copy-of select="current-group()"/></td>
	   <xsl:variable name="m">
	    <xsl:call-template name="example">
	     <xsl:with-param name="intent" select="$intent"/>
	     <xsl:with-param name="form" select="$form"/>
	     <xsl:with-param name="example" select="current-group()"/>
	    </xsl:call-template>
	   </xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="../../*[7]/node()"/></td>
	  </tr>
	 </xsl:if>
	</xsl:for-each-group>
       </xsl:when>
       <xsl:otherwise>
	<tr>
	 <xsl:sequence xmlns:f="data,f" select="f:nn($nn)"/>
	 <td><xsl:value-of select="$intent"/></td>
	 <td><xsl:copy-of select="$form"/></td>
	 <td><xsl:copy-of select="*[5]/node()"/></td>
	   <xsl:variable name="m">
	    <xsl:call-template name="example">
	     <xsl:with-param name="intent" select="$intent"/>
	     <xsl:with-param name="form" select="$form"/>
	     <xsl:with-param name="example" select="*[5]/node()"/>
	    </xsl:call-template>
	   </xsl:variable>
	   <td><pre><xsl:value-of select="serialize($m)"/></pre></td>
	   <td><math display="block"><xsl:copy-of select="$m"/></math></td>
	   <td><math display="block"><xsl:apply-templates mode="no-intent" select="$m"/></math></td>
	   <td><xsl:copy-of select="*[7]/node()"/></td>
	</tr>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
    </table>


   </body>

  </html>
 </xsl:template>

<xsl:template name="example">
	     <xsl:param name="intent"/>
	     <xsl:param name="form"/>
	     <xsl:param name="example"/>
	     <xsl:choose>

<xsl:when test="$form='infix' and matches($example,'^mo ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi>x</mi>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mi>y</mi>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='infixindexed operator' and matches($example,'^mo [∩∪]')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi>X</mi>  
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mi>Y</mi>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='infixindexed operator' and matches($example,'^mo ')">
<xsl:sequence  xml:space="preserve">
<munderover>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mn>0</mn>
 <mi>n</mi>
</munderover>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='infix' and matches($example,'^mi ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi>x</mi>
 <mi mathvariant="normal" intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
 <mi>y</mi>
</mrow>
</xsl:sequence>
</xsl:when>
<xsl:when test="$form='infix' and matches($example,'^mtext ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi>x</mi>
 <mtext intent="{$intent}"><xsl:value-of select="substring-after($example,'mtext ')"/></mtext>
 <mi>y</mi>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='system-of-equations' and $form='prefix' and matches($example,'^mo ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mtable>
  <mtr>
   <mtd><mi>x</mi><mo>+</mo><mi>y</mi></mtd>
   <mtd><mo>=</mo><mn>2</mn></mtd>
  </mtr>
  <mtr>
   <mtd><mi>x</mi><mo>−</mo><mi>y</mi></mtd>
   <mtd><mo>=</mo><mn>0</mn></mtd>
  </mtr>
 </mtable>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='prefix' and matches($example,'^mo ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mi>x</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='piecewise' and $form='mtable'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mrow><mi>f</mi><mo>(</mo><mi>x</mi><mo>)</mo></mrow>
 <mo>=</mo>
 <mo intent="{$intent}">{</mo>
 <mtable>
  <mtr>
   <mtd><mn>1</mn></mtd>
   <mtd><mtext>if&#xA0;</mtext> <mi>x</mi><mo>&gt;</mo><mn>0</mn></mtd>
  </mtr>
  <mtr>
   <mtd><mn>0</mn></mtd>
   <mtd><mtext>if&#xA0;</mtext> <mi>x</mi><mo>=</mo><mn>0</mn></mtd>
  </mtr>
  <mtr>
   <mtd><mn>−1</mn></mtd>
   <mtd><mtext>if&#xA0;</mtext> <mi>x</mi><mo>&lt;</mo><mn>0</mn></mtd>
  </mtr>
 </mtable>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='symbol / function' and matches($example,'^mi ')">
<xsl:sequence  xml:space="preserve">
<mi intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='symbol' and matches($example,'^mo ')">
 <xsl:choose>
  <xsl:when test="$intent='blank'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <m>1</m>
 <mo>+</mo>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
 <mo>=</mo>
 <mo>2</mo>
</mrow>
</xsl:sequence>
  </xsl:when>
  <xsl:otherwise>
<mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
  </xsl:otherwise>
 </xsl:choose>
</xsl:when>

<xsl:when test="$form='symbol' and matches($example,'^mn ')">
 <xsl:choose>
  <xsl:when test="$intent='blank'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <m>1</m>
 <mo>+</mo>
 <mn intent="{$intent}"><xsl:value-of select="substring-after($example,'mn ')"/></mn>
 <mo>=</mo>
 <mo>2</mo>
</mrow>
</xsl:sequence>
  </xsl:when>
  <xsl:otherwise>
<mn intent="{$intent}"><xsl:value-of select="substring-after($example,'mn ')"/></mn>
  </xsl:otherwise>
 </xsl:choose>
</xsl:when>

<xsl:when test="$form='constant' and matches($example,'^mi ')">
<xsl:sequence  xml:space="preserve">
<mi intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='symbol' and matches($example,'^mi ')">
 <xsl:choose>
  <xsl:when test="$intent='blank'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <m>1</m>
 <mo>+</mo>
 <mi intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
 <mo>=</mo>
 <mo>2</mo>
</mrow>
</xsl:sequence>
  </xsl:when>
  <xsl:otherwise>
<mi intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
  </xsl:otherwise>
 </xsl:choose>
</xsl:when>

<xsl:when test="$form='symbol' and matches($example,'^mspace *$')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <m>1</m>
 <mo>+</mo>
 <mspace intent="{$intent}" width="2em"/>
 <mo>=</mo>
 <mo>2</mo>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$form='symbol' and matches($example,'^menclose ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <m>1</m>
 <mo>+</mo>
 <menclose notation="box" intent="{$intent}">
  <mspace width="2em"/>
 </menclose>
 <mo>=</mo>
 <mo>2</mo>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="($form='postfix unit' or $form='postfix unitmsup') and matches($example,'^mi ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mn>1</mn>
 <mi mathvariant="normal" intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="matches($example,'^msup [^a-z ] *$')">
<xsl:sequence  xml:space="preserve">
<msup>
 <mi>x</mi>
 <mo intent="{$intent}"><xsl:value-of select="replace(substring-after($example,'msup '),'''','&#x2032;')"/></mo>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="matches($example,'^mover  * \$1 *[^a-z ] *$')">
<xsl:analyze-string select="$example" regex="^mover  * \$1 *([^a-z ]) *$">
<xsl:matching-substring>
<xsl:sequence  xml:space="preserve">
<mover>
 <mi>X</mi>
 <mo intent="{$intent}"><xsl:value-of select="regex-group(1)"/></mo>
</mover>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$form='postfix unitmsup' and matches($example,'^msup [^a-z]')">
<xsl:sequence  xml:space="preserve">
<msup>
 <mn>1</mn>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'msup ')"/></mo>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='postfix' and matches($example,'^mo ')">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}@postfix($a)">
 <mi arg="a">a</mi>
 <mo intent="{$intent}"><xsl:value-of select="substring-after($example,'mo ')"/></mo>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='msup' and $example='msup $1 $2'">
<xsl:sequence  xml:space="preserve">
<msup intent="{$intent}($x,$y)">
 <mi arg="x">x</mi>
 <mi arg="y">y</mi>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='msup' and $example='msup $1 -1'">
<xsl:sequence  xml:space="preserve">
<msup>
 <mi>x</mi>
 <mn intent="{$intent}">−1</mn>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$form='fenced' and matches($example,'mrow *[^a-z]\$1 *[^a-z] *\$2 *[^a-z] *$')">
<xsl:analyze-string select="$example" regex="mrow *([^a-z])\$1 *([^a-z]) *\$2 *([^a-z]) *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($a,$b)">
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
 <mi arg="a">a</mi>
 <mo><xsl:value-of select="regex-group(2)"/></mo>
 <mi arg="b">b</mi>
 <mo><xsl:value-of select="regex-group(3)"/></mo>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>


<xsl:when test="$form='fenced' and matches($example,'mrow *[^a-z] *\.\.\. *[^a-z] *$')">
<xsl:analyze-string select="$example" regex="mrow *([^a-z]) *\.\.\. *([^a-z]) *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($x,$y,$dots)">
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
 <mi arg="x">x</mi>
 <mo>,</mo>
 <mi arg="y">y</mi>
 <mo>,</mo>
 <mo arg="dots">&#x22EF;</mo>
 <mo><xsl:value-of select="regex-group(2)"/></mo>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$intent='matrix' and matches($example,'^mrow *([^a-z ]) *mtable *([^a-z]) *$')">
<xsl:analyze-string select="$example" regex="^mrow *([^a-z ]) *mtable *([^a-z]) *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
 <mtable>
  <mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr>
  <mtr><mtd><mi>x</mi></mtd><mtd><mi>y</mi></mtd></mtr>
 </mtable>
 <mo><xsl:value-of select="regex-group(2)"/></mo>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="($form='msup' or $form='msupmoverfunction') and matches($example,'msup *\$1 *[^a-z]$')">
<xsl:analyze-string select="$example" regex="msup *\$1 *([^a-z])$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<msup intent="{$intent}($a)">
 <mi arg="a">a</mi>
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
</msup>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="($form='mover' or $form='msupmoverfunction') and matches($example,'mover *\$1 *[^a-z]$')">
<xsl:analyze-string select="$example" regex="mover *\$1 *([^a-z])$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mover intent="{$intent}($a)">
 <mi arg="a">a</mi>
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
</mover>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$form='mover' and matches($example,'mover *[^a-z]$')">
<xsl:analyze-string select="$example" regex="mover *([^a-z])$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mover intent="{$intent}($a,$b)">
 <mrow><mi arg="a">a</mi><mi arg="b">b</mi></mrow>
 <mo><xsl:value-of select="regex-group(1)"/></mo>  
</mover>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>


<xsl:when test="$form='mover' and matches($example,'mover *\$1 *\$2$')">
<xsl:sequence  xml:space="preserve">
<mover intent="{$intent}($a,$b)">
 <mi arg="a">a</mi>
 <mi arg="b">b</mi>
</mover>
</xsl:sequence>
</xsl:when>

<xsl:when test="($form='fenced' or $form='fencedfunction') and matches($example,'^mrow *([^a-z ]) *\$1 *([^a-z ]) *$')">
 <xsl:analyze-string select="$example" regex="mrow *([^a-z ]) *\$1 *([^a-z ]) *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($a)">
 <mo><xsl:value-of select="regex-group(1)"/></mo> 
 <mi arg="a">a</mi>
 <mo><xsl:value-of select="regex-group(2)"/></mo>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
 </xsl:analyze-string>
</xsl:when>

<xsl:when test="($form='function' or $form='fencedfunction') and matches($example,'^mi ')">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi mathvariant="normal"
     intent="{$intent}"><xsl:value-of select="substring-after($example,'mi ')"/></mi>
 <mi>x</mi>
</mrow>
</xsl:sequence>
</xsl:when>



<xsl:when test="$form='postfix' and matches($example,'\$1 *\([^ ]*\)$')">
<xsl:analyze-string select="$example" regex="\$1 *\(([^ ]*)\)$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($X)">
 <mi arg="X">X</mi>
 <mrow>
  <mo>(</mo>
  <mi mathvariant="normal"><xsl:value-of select="regex-group(1)"/></mi>
  <mo>)</mo>
 </mrow>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$form='mixfix' and $example='mrow $1($2,$3)'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($a,$b)">
 <mi>P</mi>
 <mrow>
  <mo>(</mo>
  <mi arg="a">a</mi>
  <mo>,</mo>
  <mi arg="b">b</mi>
  <mo>)</mo>
 </mrow>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$form='msqrt' and $example='msqrt'">
<xsl:sequence  xml:space="preserve">
<msqrt intent="{$intent}($a)">
 <mi arg="a">a</mi>
</msqrt>
</xsl:sequence>
</xsl:when>


<xsl:when test="$form='mroot' and $example='mroot'">
<xsl:sequence  xml:space="preserve">
<mroot intent="{$intent}($a,$n)">
 <mi arg="a">a</mi>
 <mn arg="n">3</mn>
</mroot>
</xsl:sequence>
</xsl:when>



<xsl:when test="$form='prefix' and matches($example,'mrow *[^a-z] *\$1\$2\$3 *$')">
<xsl:analyze-string select="$example" regex="mrow *([^a-z]) *\$1\$2\$3 *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($a,$b,$c)">
 <mo><xsl:value-of select="regex-group(1)"/></mo>   
 <mrow>
  <mi arg="a">a</mi>
  <mi arg="b">b</mi>
  <mi arg="c">c</mi>
 </mrow>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$form='prefix' and matches($example,'mrow *[^a-z] *\$1\$2\$3\$4 *$')">
<xsl:analyze-string select="$example" regex="mrow *([^a-z]) *\$1\$2\$3\$4 *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mo><xsl:value-of select="regex-group(1)"/></mo>   
 <mrow>
  <mi>a</mi><mi>b</mi><mi>c</mi><mi>d</mi>
 </mrow>
</mrow>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>


<xsl:when test="matches($example,'(m[a-z]*) *\$1 *\$2 *$')">
<xsl:analyze-string select="$example" regex="(m[a-z]*) *\$1 *\$2 *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<xsl:element name="{regex-group(1)}"><xsl:attribute name="intent" select="concat($intent,'($A,$B)')"/>
  <mi arg="A">A</mi>
  <mi arg="B">B</mi>
</xsl:element>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>



<xsl:when test="matches($example,'(m[a-z]*) *\$1 *\$2 *\$3 *$')">
<xsl:analyze-string select="$example" regex="(m[a-z]*) *\$1 *\$2 *\$3 *$">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<xsl:element name="{regex-group(1)}"><xsl:attribute name="intent" select="concat($intent,'($X,$a,$b)')"/>
  <mi arg="X">X</mi>
  <mi arg="a">a</mi>
  <mi arg="b">b</mi>
</xsl:element>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="matches($example,'mtext *([a-z]+) *$')">
<xsl:analyze-string select="$example" regex="mtext *([a-z]+) *">
<xsl:matching-substring>  
<xsl:sequence  xml:space="preserve">
<mtext intent="{$intent}"><xsl:value-of select="regex-group(1)"/></mtext>
</xsl:sequence>
</xsl:matching-substring>
</xsl:analyze-string>
</xsl:when>

<xsl:when test="$intent='continued-fraction'">
<xsl:sequence  xml:space="preserve">
<mfrac numalign="left" intent="continued-fraction">
 <mn>1</mn>
 <mrow>
  <mn>1</mn>
  <mo>+</mo>
  <mfrac numalign="left" intent="continued-fraction">
   <mn>1</mn>
   <mrow>
    <mn>1</mn>
    <mo>+</mo>
    <mfrac numalign="left" intent="continued-fraction">
     <mn>1</mn>
     <mo>&#x22F1;</mo>
    </mfrac>
   </mrow>
  </mfrac>
 </mrow>
</mfrac>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='rate' and $example='mfrac'">
<xsl:sequence  xml:space="preserve">
<mfrac intent="{$intent}($m,$s)">
 <mi arg="m" intent="unit">m</mi>
 <mi arg="s" intent="unit">s</mi>
</mfrac>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='rate' and $example='$1p$2'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($m,$s)">
 <mi arg="m" intent="unit">m</mi>
 <mo>/</mo>
 <mi arg="s" intent="unit">s</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='shape' and $form='n-ary concat'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mi>A</mi><mi>B</mi><mi>C</mi><mi>D</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='binomial-coefficient'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}($a,$b)">
 <mo>(</mo>
 <mfrac linethickness="0pt">
  <mi arg="a">a</mi>
  <mi arg="b">b</mi>
 </mfrac>
 <mo>)</mo>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='transpose' and normalize-space($example)=''">
<xsl:sequence  xml:space="preserve">
<msup>
 <mi>x</mi>
 <mi intent="transpose" mathvariant="normal">T</mi>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='angular-description' and normalize-space($example)='mrow $1-$2-$3'">
<xsl:sequence  xml:space="preserve">
<mrow intent="angular-description">
 <mi>X</mi><mo>−</mo><mi>Y</mi><mo>−</mo><mi>Z</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='more-than' and normalize-space($example)='$1_{>0}'">
<xsl:sequence  xml:space="preserve">
<msub intent="more-than($N,$z)"><xsl:comment select="'positive?'"/>
 <mi arg="N">ℕ</mi>
 <mrow>
  <mo>&gt;</mo>
  <mn arg="z">0</mn>
 </mrow>
</msub>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='more-than' and normalize-space($example)='$1 > 0'">
<xsl:sequence  xml:space="preserve">
<mrow intent="more-than($x,$z)">
 <mi arg="x">x</mi>
 <mo>&gt;</mo>
 <mn arg="z">0</mn>
</mrow>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='more-than' and normalize-space($example)='M > 0'">
<xsl:sequence  xml:space="preserve">
<mrow intent="more-than($M,$z)"><xsl:comment select="'positive-definite?'"/>
 <mi arg="M">M</mi>
 <mo>&gt;</mo>
 <mn arg="z">0</mn>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='less-than' and $form='infix'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi>x</mi>
 <mo intent="less-than">&lt;</mo>
 <mi>y</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='array' and $form='tabular'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mo>(</mo>  
 <mtable>
  <mtr><mtd><mi>a</mi></mtd><mtd><mi>b</mi></mtd></mtr>
  <mtr><mtd><mi>x</mi></mtd><mtd><mi>y</mi></mtd></mtr>
 </mtable>
 <mo>)</mo>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='dollar' and $form='prefix unit'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi intent="dollar">$</mi>
 <mn>1</mn>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='fraction' and $form='2D'">
<xsl:sequence  xml:space="preserve">
<mfrac intent="fraction($x,$y)">
 <mi arg="x">x</mi>
 <mi arg="y">y</mi>
</mfrac>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='focus' and $form='enclosed'">
<xsl:sequence  xml:space="preserve">
<menclose notation="box" intent="{$intent}">
 <mspace width="2em"/>
</menclose>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='ordinal-mark' and $example='msup th'">
<xsl:sequence  xml:space="preserve">
<msup>
 <mn>4</mn>
 <mi intent="{$intent}">th</mi>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='ordinal-mark' and $example='msup rd'">
<xsl:sequence  xml:space="preserve">
<msup>
 <mn>3</mn>
 <mi intent="{$intent}">rd</mi>
</msup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='ordinal-mark' and $example='msup nd'">
<xsl:sequence  xml:space="preserve">
<msup>
 <mn>2</mn>
 <mi intent="{$intent}">nd</mi>
</msup>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='least-common-denominator' and $example='LCM'">
<xsl:sequence  xml:space="preserve">
<mrow>
 <mi intent="{$intent}">lcm</mi>
 <mo>(</mo>
 <mi>x</mi>
 <mo>,</mo>
 <mi>y</mi>
 <mo>)</mo>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='translation' and $example='msub T ($1, $2)'">
<xsl:sequence  xml:space="preserve">
<msub intent="{$intent}($a,$b)">
 <mi mathvariant="normal">T</mi>
 <mrow>
  <mo>(</mo>
  <mi arg="a">a</mi>
  <mo>,</mo>
  <mi arg="b">b</mi>
  <mo>)</mo>
 </mrow>
</msub>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='positive' and $form='prefixatom'">
<xsl:sequence  xml:space="preserve">
<mo intent="{$intent}">+</mo>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='negative' and $form='prefixatom'">
<xsl:sequence  xml:space="preserve">
<mo intent="{$intent}">−</mo>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='sequence-range' and starts-with($example,'msubsup')">
<xsl:sequence  xml:space="preserve">
<msubsup intent="{$intent}">
 <mi>x</mi>
 <mrow><mi>i</mi><mo>=</mo><mn>0</mn></mrow>
 <mi>n</mi>
</msubsup>
</xsl:sequence>
</xsl:when>

<xsl:when test="$intent='sequence-range' and starts-with($example,'munderover')">
<xsl:sequence  xml:space="preserve">
<munderover intent="{$intent}">
 <mi>x</mi>
 <mrow><mi>i</mi><mo>=</mo><mn>0</mn></mrow>
 <mi>n</mi>
</munderover>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='progression' and $example='{ $1, $2 ... $n }'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mi>x</mi>
 <mo>,</mo>
 <mi>y</mi>
 <mo>,</mo>
 <mi>c</mi>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='progression' and $example='( msub $1 $2 )'">
<xsl:sequence  xml:space="preserve">
<mrow intent="{$intent}">
 <mo>(</mo>  
 <msub>
  <mi>X</mi>
  <mi>i</mi>
 </msub>
 <mo>)</mo>
</mrow>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='braced-group' and starts-with($example,'munder')">
<xsl:sequence  xml:space="preserve">
<munder intent="{$intent}">
 <mrow><mi>x</mi><mi>y</mi><mi>z</mi></mrow>
 <mo>&#x23DF;</mo>
</munder>
</xsl:sequence>
</xsl:when>


<xsl:when test="$intent='braced-group' and starts-with($example,'mover')">
<xsl:sequence  xml:space="preserve">
<mover intent="{$intent}">
 <mrow><mi>x</mi><mi>y</mi><mi>z</mi></mrow>
 <mo>&#x23DE;</mo>
</mover>
</xsl:sequence>
</xsl:when>



<xsl:otherwise>
<xsl:sequence  xml:space="preserve">
 <mtext style="color:red"><xsl:value-of select="$intent"/></mtext>
</xsl:sequence>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template mode="no-intent" match="node()">
 <xsl:copy>
  <xsl:copy-of select="@* except @intent"/>
  <xsl:apply-templates mode="no-intent"/>
 </xsl:copy>
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
