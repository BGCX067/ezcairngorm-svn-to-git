<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="xml" encoding="UTF-8"/>
  
  <xsl:param name="ns"/>
  
  <xsl:template match="/mysqldump/database">

    <objects>
      <xsl:attribute name="ns">
           <xsl:value-of select="$ns"/>
      </xsl:attribute>

      <xsl:apply-templates select="table_structure"/>
    </objects>
  </xsl:template>

  <xsl:template match="table_structure">
    <object name="{@name}">
      <xsl:apply-templates select="field"/>
    </object>
  </xsl:template>
  
  <xsl:template match="field">
    <field name="{@Field}">

        <xsl:if test="contains(@Type, 'int')">
              <xsl:attribute name="type">INTEGER</xsl:attribute>
              <xsl:attribute name="astype">int</xsl:attribute>
        </xsl:if>
                
        <xsl:if test="contains(@Type, 'double')">
              <xsl:attribute name="type">FLOAT</xsl:attribute>
              <xsl:attribute name="astype">Number</xsl:attribute>
        </xsl:if>

        <xsl:if test="contains(@Type, 'decimal')">
              <xsl:attribute name="type">FLOAT</xsl:attribute>
              <xsl:attribute name="astype">Number</xsl:attribute>
        </xsl:if>
        
        <xsl:if test="contains(@Type, 'char')">
              <xsl:attribute name="type">STRING</xsl:attribute>
              <xsl:attribute name="astype">String</xsl:attribute>
        </xsl:if>

        <xsl:if test="contains(@Type, 'text')">
              <xsl:attribute name="type">STRING</xsl:attribute>
              <xsl:attribute name="astype">String</xsl:attribute>
        </xsl:if>

        <xsl:if test="contains(@Type, 'date')">
              <xsl:attribute name="type">DATE</xsl:attribute>
              <xsl:attribute name="astype">Date</xsl:attribute>
        </xsl:if>
        
        <xsl:if test="contains(@Type, 'time')">
              <xsl:attribute name="type">DATE</xsl:attribute>
              <xsl:attribute name="astype">Date</xsl:attribute>
        </xsl:if>
        
    </field>
  </xsl:template>


</xsl:stylesheet>
