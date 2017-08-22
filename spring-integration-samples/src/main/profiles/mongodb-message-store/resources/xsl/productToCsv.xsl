<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="2.0"
	xmlns:ns1="http://erdprt.org/ProductStructure"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="text" encoding="UTF-8" indent="yes" />
	
	<xsl:strip-space elements="*" />
	<xsl:variable name="newLine" select="'&#10;'"/>
	
	<xsl:template match="/">

		<xsl:for-each select="/ns1:Message/ns1:MetaData">
			<xsl:call-template name="makeMetadata">
			</xsl:call-template>
		</xsl:for-each>
		
		<xsl:for-each select="/ns1:Message/ns1:Body/ns1:products/ns1:product">
			<xsl:call-template name="makeProduct">
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="makeMetadata">

		<xsl:value-of select="'METADATA'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:from" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:to" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:contentType" />
		<xsl:value-of select="$newLine" />
		
	</xsl:template>
	
	<!-- build product line  -->
	<xsl:template name="makeProduct">

		<xsl:value-of select="'PRODUCT'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@quantity" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@date" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@price" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@category" />
		<xsl:value-of select="$newLine" />
		
	</xsl:template>
	
</xsl:stylesheet>