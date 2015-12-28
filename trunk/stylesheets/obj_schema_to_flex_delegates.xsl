<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/objects">
    <xsl:apply-templates select="object"/>
  </xsl:template>

  <xsl:template match="object">
  
###separator### <xsl:value-of select="parent::*/@ns"/>.business.<xsl:value-of select="@name_cc_uf"/>Delegate.as
package <xsl:value-of select="parent::*/@ns"/>.business
{
	import mx.rpc.IResponder;
	import com.adobe.cairngorm.business.ServiceLocator;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class <xsl:value-of select="@name_cc_uf"/>Delegate
	{
		 private var responder:IResponder;
		 private var service:Object;
	   
		 public function <xsl:value-of select="@name_cc_uf"/>Delegate(responder:IResponder):void
		 {     
			  this.service = // ServiceLocator.getInstance();
			  this.responder = responder;
		 }
	   	 
    <xsl:call-template name="method_code">
        <xsl:with-param name="cmd_name">Create</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="method_code">
        <xsl:with-param name="cmd_name">Read</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="method_code">
        <xsl:with-param name="cmd_name">Update</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="method_code">
        <xsl:with-param name="cmd_name">Delete</xsl:with-param>
    </xsl:call-template>	
	}
}    
  </xsl:template>


  <xsl:template name="method_code">
    <xsl:param name="cmd_name"/>  
		 public function <xsl:value-of select="@name_cc_lf"/><xsl:value-of select="$cmd_name"/>():void
		 {  
			 var call:Object = service.<xsl:value-of select="@name_cc_lf"/><xsl:value-of select="$cmd_name"/>();
			 call.addResponder(responder);
		 } 
  </xsl:template>
  
</xsl:stylesheet>
