<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="2.0"
	xmlns:ns1="http://erdprt.org/PersonStructure"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="text" encoding="UTF-8" indent="yes" />
	
	<xsl:strip-space elements="*" />
	<xsl:variable name="newLine" select="'&#10;'"/>
	
	<xsl:template match="/">

		<xsl:value-of select="'METADATA'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:from" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:to" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:contentType" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="$newLine" />
		
		<!-- civil status part  -->
		<xsl:value-of select="'CIVILSTATUS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@lastName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@firstName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@civility" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@birthDate" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@nationality" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="$newLine" />
		
		<!-- Address Part -->
		<xsl:value-of select="'ADDRESS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@street" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@city" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@zipCode" />
		<xsl:text>|</xsl:text>	
	</xsl:template>
	
</xsl:stylesheet>