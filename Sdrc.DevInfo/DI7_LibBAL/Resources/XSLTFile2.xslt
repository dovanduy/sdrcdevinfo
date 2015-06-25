<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="*">
    <html>
      <head>
        <STYLE type="text/css">
          .HeaderItems
          {
          font-size: 9pt;
          color: black;
          font-family: Arial, Verdana, Helvetica, sans-serif;
          font-weight:bold;
          background-color:#cccccc;
          }
          .LeftPanelItems
          {
          font-size: 9pt;
          color: black;
          font-family: Arial, Verdana, Helvetica, sans-serif;
          font-weight:bold
          }
          .RightPanelItems
          {
          font-size: 9pt;
          color: black;
          font-family: Arial, Verdana, Helvetica, sans-serif;
          }
        </STYLE>
      </head>
      <body>
        <table cellpadding="0"  border="0" width="100%">
          <tr class="HeaderItems">
            <th align="left" colspan="0">Element</th>
            <th align="Left">Value</th>
          </tr>

          <xsl:for-each select="*[local-name()='MetadataSet']">
            <xsl:for-each select="*[local-name()='Report']">
              <xsl:for-each select="*[local-name()='AttributeSet']">
                <xsl:for-each select="*[local-name()='ReportedAttribute']">


                  <xsl:choose>
                    <xsl:when test="count(descendant::*)=0">
                      <tr>
                        <td class="LeftPanelItems" valign="top" align="left"  colspan="2">
                          <xsl:value-of select="@name"/>
                        </td>
                      </tr>
                    </xsl:when>
                    <xsl:otherwise>
                      <tr>
                        <td class="LeftPanelItems" valign="top" align="left" >
                          <xsl:value-of select="@name"/>
                        </td>


                        <td class="RightPanelItems" valign="top" align="Left" width="90%">
                          <xsl:for-each select="*">
                            <xsl:if test="local-name()='Text'">

                              <xsl:call-template name="Split">
                                <xsl:with-param name="list">
                                  <xsl:value-of select="."/>
                                </xsl:with-param>
                              </xsl:call-template>
                            </xsl:if>
                          </xsl:for-each>
                        </td>

                      </tr>

                      <tr>
                        <td></td>
                        <td>
                          <table cellpadding="0"  border="0" width="100%">



                            <xsl:for-each select="*[local-name()='AttributeSet']">
                              <xsl:for-each select="*[local-name()='ReportedAttribute']">
                                <tr>
                                  <td class="LeftPanelItems" valign="top" align="left" rowspan="$rows">
                                    <xsl:value-of select="@name"/>
                                  </td>
                                  <td class="RightPanelItems" valign="top" align="Left" width="90%">
                                    <xsl:for-each select="*[local-name()='Text'][1]"/>

                                    <xsl:call-template name="Split">
                                      <xsl:with-param name="list">
                                        <xsl:value-of select="."/>
                                      </xsl:with-param>
                                    </xsl:call-template>

                                  </td>
                                </tr>

                              </xsl:for-each>
                            </xsl:for-each>


                          </table>
                        </td>
                      </tr>


                    </xsl:otherwise>
                  </xsl:choose>



                </xsl:for-each>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>


  <xsl:template name="Split">
    <xsl:param name="list"/>
    <xsl:variable name="delimiter" select="' '"/>
    <xsl:variable name="newlist">
      <xsl:choose>
        <xsl:when test="contains($list, $delimiter)">
          <xsl:value-of select="normalize-space($list)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat(normalize-space($list), $delimiter)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="URL">
      <xsl:with-param name="NodeValue">
        <xsl:value-of select="concat(substring-before($newlist,$delimiter),$delimiter)"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:variable name="remaining" select="substring-after($newlist, $delimiter)"/>
    <xsl:if test="$remaining">
      <xsl:call-template name="Split">
        <xsl:with-param name="list" select="$remaining"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="URL">
    <xsl:param name="NodeValue">
    </xsl:param>
    <xsl:choose>
      <xsl:when test="contains($NodeValue,'__DIIMG__')">
        <xsl:call-template name="ShowImage">
          <xsl:with-param name="Type">
            <xsl:text>+</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue">
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>



      <xsl:when test="contains($NodeValue,'{{~}}')">
        <xsl:call-template name="InsertNewLine">
          <xsl:with-param name="Type">
            <xsl:text>+</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue">
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>



      <xsl:when test="contains($NodeValue,'http:')">
        <xsl:call-template name="MakeURL">
          <xsl:with-param name="Type">
            <xsl:text>http:</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue">
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>


      <xsl:when test="contains($NodeValue,'file:///')">
        <xsl:call-template name="MakeFileURL">
          <xsl:with-param name="Type">
            <xsl:text>file:///</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue">
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>



      <xsl:when test="contains($NodeValue,'www.')">
        <xsl:call-template name="MakeURL">
          <xsl:with-param name="Type">
            <xsl:text>www.</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue">
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($NodeValue,'@')">
        <xsl:call-template name="MakeURL">
          <xsl:with-param name="Type">
            <xsl:text>@</xsl:text>
          </xsl:with-param>
          <xsl:with-param name="NodeValue" select="$NodeValue"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="substring($NodeValue,0)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ShowImage">
    <xsl:param name="Type"/>
    <xsl:param name="NodeValue"> </xsl:param>
    <xsl:variable name="URL">
      <xsl:call-template name="replaceCharsInString">
        <xsl:with-param name="stringIn" select="normalize-space($NodeValue)"/>
        <xsl:with-param name="charsIn" select="'__DIIMG__'"/>
        <xsl:with-param name="charsOut" select="''"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="img">
      <!--<xsl:attribute name="src">-->
      <xsl:attribute name="Src">
        <xsl:value-of select="normalize-space($URL)"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>

  <xsl:template name="InsertNewLine">
    <xsl:param name="Type"/>
    <xsl:param name="NodeValue"> </xsl:param>
    <xsl:variable name="URL">
      <xsl:call-template name="replaceCharsInString">
        <xsl:with-param name="stringIn" select="normalize-space($NodeValue)"/>
        <xsl:with-param name="charsIn" select="'{{~}}'"/>
        <xsl:with-param name="charsOut" select="''"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="br">
    </xsl:element>
  </xsl:template>

  <xsl:template name="replaceCharsInString">
    <xsl:param name="stringIn"/>
    <xsl:param name="charsIn"/>
    <xsl:param name="charsOut"/>
    <xsl:choose>
      <xsl:when test="contains($stringIn,$charsIn)">
        <xsl:value-of select="concat(substring-before($stringIn,$charsIn),$charsOut)"/>
        <xsl:call-template name="replaceCharsInString">
          <xsl:with-param name="stringIn" select="substring-after($stringIn,$charsIn)"/>
          <xsl:with-param name="charsIn" select="$charsIn"/>
          <xsl:with-param name="charsOut" select="$charsOut"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$stringIn"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="MakeURL">
    <xsl:param name="Type">
    </xsl:param>
    <xsl:param name="NodeValue"/>
    <xsl:variable name="URL">
      <xsl:call-template name="RemoveSpecialsChar">
        <xsl:with-param name="myString" select="normalize-space($NodeValue)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="contains($URL,$Type)">
      <xsl:if test="$Type!='@'">
        <xsl:value-of select="normalize-space(substring-before($URL,$Type))"/>
      </xsl:if>
      <xsl:variable name="l1">
        <xsl:value-of select="string-length(substring-before($URL,$Type))"/>
      </xsl:variable>
      <xsl:variable name="pattern" select="' '"/>
      <xsl:element name="A">
        <xsl:choose>
          <xsl:when test="$Type='www.'">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('http://',normalize-space(substring($URL,$l1+1)))"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank
 </xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring($URL,$l1+1)"/>
          </xsl:when>
          <xsl:when test="$Type='@'">
            <xsl:call-template name="Email">
              <xsl:with-param name="EmailID" select="$URL">
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href">
              <xsl:value-of select="normalize-space(substring($URL,$l1+1))"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring($URL,$l1+1)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <xsl:value-of select="substring-after($NodeValue,$URL)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="MakeFileURL">
    <xsl:param name="Type">
    </xsl:param>
    <xsl:param name="NodeValue"/>
    <xsl:variable name="URL">
      <xsl:call-template name="RemoveSpecialsChar">
        <xsl:with-param name="myString" select="normalize-space($NodeValue)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="contains($URL,$Type)">
      <xsl:if test="$Type!='@'">
        <xsl:value-of select="normalize-space(substring-before($URL,$Type))"/>
      </xsl:if>
      <xsl:variable name="l1">
        <xsl:value-of select="string-length(substring-before($URL,$Type))"/>
      </xsl:variable>
      <xsl:variable name="pattern" select="' '"/>
      <xsl:element name="A">
        <xsl:choose>
          <xsl:when test="$Type='www.'">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('file:///',normalize-space(substring($URL,$l1+1)))"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank
 </xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring($URL,$l1+1)"/>
          </xsl:when>
          <xsl:when test="$Type='@'">
            <xsl:call-template name="Email">
              <xsl:with-param name="EmailID" select="$URL">
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="href">
              <xsl:value-of select="normalize-space(substring($URL,$l1+1))"/>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring($URL,$l1+1)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <xsl:value-of select="substring-after($NodeValue,$URL)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="Email">
    <xsl:param name="EmailID"/>
    <xsl:choose>
      <xsl:when test="contains($EmailID,',')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>,</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'(')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>(</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,')')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>)</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'!')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>!</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'&amp;')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>&amp;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'&gt;')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>&gt;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'&lt;')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>&lt;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <!-- <xsl:when test="contains($EmailID,''')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>'</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>-->
      <xsl:when test="contains($EmailID,':')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>:</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($EmailID,'?')">
        <xsl:call-template name="EmailHyperLink">
          <xsl:with-param name="NodeValue">
            <xsl:value-of select="$EmailID"/>
          </xsl:with-param>
          <xsl:with-param name="delimiter">
            <xsl:text>?</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="A">
          <xsl:attribute name="href">
            <xsl:value-of select="concat('mailto:',normalize-space(substring($EmailID,0)))"/>
          </xsl:attribute>
          <xsl:value-of select="substring($EmailID,0)"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="EmailHyperLink">
    <xsl:param name="NodeValue"/>
    <xsl:param name="delimiter"/>
    <xsl:value-of select="concat(substring-before($NodeValue,$delimiter),$delimiter)"/>
    <xsl:element name="A">
      <xsl:attribute name="href">
        <xsl:value-of select="concat('mailto:',normalize-space(substring-after($NodeValue,$delimiter)))"/>
      </xsl:attribute>
      <xsl:value-of select="substring-after($NodeValue,$delimiter)"/>
    </xsl:element>
  </xsl:template>

  <xsl:template name="RemoveSpecialsChar">
    <xsl:param name="myString"/>
    <xsl:choose>
      <xsl:when test="substring($myString, string-length($myString) - string-length('.') &#xA;+ 1, string-length('.')) ='.' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>.</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length(')') &#xA;+ 1, string-length(')')) =')' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>)</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('!') &#xA;+ 1, string-length('!')) ='!' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>!</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('-') &#xA;+ 1, string-length('-')) ='-' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>-</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('$') &#xA;+ 1, string-length('(')) ='(' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>.</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('$') &#xA;+ 1, string-length('$')) ='$' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>.</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('%') &#xA;+ 1, string-length('%')) ='.' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>%</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('&amp;') &#xA;+ 1, string-length('&amp;')) ='&amp;' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>&amp;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('&lt;') &#xA;+ 1, string-length('&lt;')) ='&lt;' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>&lt;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('&gt;') &#xA;+ 1, string-length('&gt;')) ='&gt;' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>&gt;</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('+') &#xA;+ 1, string-length('+')) ='+' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>+</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length(',') &#xA;+ 1, string-length(',')) =',' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>,</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('_') &#xA;+ 1, string-length('_')) ='_' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>_</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('|') &#xA;+ 1, string-length('|')) ='|' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>|</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('=') &#xA;+ 1, string-length('=')) ='=' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>=</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('*') &#xA;+ 1, string-length('*')) ='*' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>*</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('{') &#xA;+ 1, string-length('{')) ='{' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>{</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('}') &#xA;+ 1, string-length('}')) ='}' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>}</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length(']') &#xA;+ 1, string-length(']')) =']' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>]</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('[') &#xA;+ 1, string-length('[')) ='}' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>[</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length(':') &#xA;+ 1, string-length(':')) =':' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>:</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('~') &#xA;+ 1, string-length('~')) ='~' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>~</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('^') &#xA;+ 1, string-length('^')) ='^' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>^</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('#') &#xA;+ 1, string-length('#')) ='}' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>#</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="substring($myString, string-length($myString) - string-length('`') &#xA;+ 1, string-length('`')) ='}' ">
        <xsl:call-template name="RemoveChar">
          <xsl:with-param name="myString" select="$myString"/>
          <xsl:with-param name="myPattern">
            <xsl:text>`</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$myString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="RemoveChar">
    <xsl:param name="myString"/>
    <xsl:param name="myPattern"/>
    <xsl:call-template name="RemoveSpecialsChar">
      <xsl:with-param name="myString" select="substring($myString, 0,string-length($myString))"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="translate(., '&#xA;&#xD;', '  ')"/>
  </xsl:template>


</xsl:stylesheet>