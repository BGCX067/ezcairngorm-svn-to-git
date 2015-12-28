<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/objects">
    <xsl:apply-templates select="object"/>
  </xsl:template>

  <xsl:template match="object">
  
###separator### <xsl:value-of select="parent::*/@ns"/>.event.<xsl:value-of select="@name_cc_uf"/>Event.as
package <xsl:value-of select="parent::*/@ns"/>.event
{
	import <xsl:value-of select="parent::*/@ns"/>.vo.<xsl:value-of select="@name_cc_uf"/>VO;
	import com.adobe.cairngorm.control.CairngormEvent;

	public class <xsl:value-of select="@name_cc_uf"/>Event
	extends CairngormEvent
	{

    <xsl:call-template name="type_var_code">
        <xsl:with-param name="cmd_name">Create</xsl:with-param>
        <xsl:with-param name="cmd_name_uc">CREATE</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="type_var_code">
        <xsl:with-param name="cmd_name">Read</xsl:with-param>
        <xsl:with-param name="cmd_name_uc">READ</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="type_var_code">
        <xsl:with-param name="cmd_name">Update</xsl:with-param>
        <xsl:with-param name="cmd_name_uc">UPDATE</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="type_var_code">
        <xsl:with-param name="cmd_name">Delete</xsl:with-param>
        <xsl:with-param name="cmd_name_uc">DELETE</xsl:with-param>
    </xsl:call-template>
    
		public var obj:<xsl:value-of select="@name_cc_uf"/>VO = null;

		public function <xsl:value-of select="@name_cc_uf"/>Event(type:String, obj:<xsl:value-of select="@name_cc_uf"/>VO = null)
		{
			this.obj = obj;
			super(type);
		}
	}
}    
  </xsl:template>


  <xsl:template name="type_var_code">
    <xsl:param name="cmd_name"/> 
    <xsl:param name="cmd_name_uc"/>
		public static var <xsl:value-of select="$cmd_name_uc"/>:String = "<xsl:value-of select="@name_cc_lf"/><xsl:value-of select="$cmd_name"/>"; 
  </xsl:template>

</xsl:stylesheet>
