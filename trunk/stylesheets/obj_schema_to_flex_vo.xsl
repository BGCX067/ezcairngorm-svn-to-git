<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/objects">
    <xsl:apply-templates select="object"/>
  </xsl:template>

  <xsl:template match="object">
  
###separator### <xsl:value-of select="parent::*/@ns"/>.vo.<xsl:value-of select="@name_cc_uf"/>VO.as 
package <xsl:value-of select="parent::*/@ns"/>.vo 
{ 	 	
    [Bindable]     
    [RemoteClass(alias="<xsl:value-of select="@name_cc_uf"/>VO")] 	
    public class <xsl:value-of select="@name_cc_uf"/>VO 	
    {
    <xsl:apply-templates select="field"/>
    }
}
  </xsl:template>

  <xsl:template match="field">
      private var _<xsl:value-of select="@name_cc_lf"/>:<xsl:value-of select="@astype"/>;
      public function get <xsl:value-of select="@name_cc_lf"/>():<xsl:value-of select="@astype"/>{ return _<xsl:value-of select="@name_cc_lf"/>; }
      public function set <xsl:value-of select="@name_cc_lf"/>(value:<xsl:value-of select="@astype"/>):void{ _<xsl:value-of select="@name_cc_lf"/> = value; }      
  </xsl:template>

</xsl:stylesheet>
