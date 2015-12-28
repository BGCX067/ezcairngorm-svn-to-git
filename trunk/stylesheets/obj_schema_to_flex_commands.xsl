<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="/objects">
    <xsl:apply-templates select="object"/>
  </xsl:template>

  <xsl:template match="object">
    <xsl:call-template name="cmd_class_code">
        <xsl:with-param name="cmd_name">Create</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="cmd_class_code">
        <xsl:with-param name="cmd_name">Read</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="cmd_class_code">
        <xsl:with-param name="cmd_name">Update</xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="cmd_class_code">
        <xsl:with-param name="cmd_name">Delete</xsl:with-param>
    </xsl:call-template>  
  </xsl:template>


  <xsl:template name="cmd_class_code">
    <xsl:param name="cmd_name"/>  
###separator### <xsl:value-of select="parent::*/@ns"/>.commands.<xsl:value-of select="@name_ns_lc"/>.<xsl:value-of select="@name_cc_uf"/><xsl:value-of select="$cmd_name"/>Cmd.as 
package <xsl:value-of select="parent::*/@ns"/>.commands.<xsl:value-of select="@name_ns_lc"/>
{
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;	
	import com.adobe.cairngorm.commands.ICommand;
	
	import <xsl:value-of select="parent::*/@ns"/>.vo.*;
	import <xsl:value-of select="parent::*/@ns"/>.event.*;
	import <xsl:value-of select="parent::*/@ns"/>.model.*;
	import <xsl:value-of select="parent::*/@ns"/>.business.<xsl:value-of select="@name_cc_uf"/>Delegate;
	
	public class <xsl:value-of select="@name_cc_uf"/><xsl:value-of select="$cmd_name"/>Cmd 
	implements ICommand, IResponder
	{	
		private var obj:<xsl:value-of select="@name_cc_uf"/>VO;
		private var delegate:<xsl:value-of select="@name_cc_uf"/>Delegate;
		
		public function execute(event:CairngormEvent):void
		{	    	
		}
		
		public function result(data:Object):void
		{						
		}
		
		public function fault(info:Object):void
		{
		}		
	}
}  
  </xsl:template>
  
</xsl:stylesheet>
