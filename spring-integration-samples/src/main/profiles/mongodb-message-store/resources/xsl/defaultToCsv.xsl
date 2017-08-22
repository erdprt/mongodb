<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="2.0"
	xmlns:ns1="http://erdprt.org/DefaultStructure"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="text" encoding="UTF-8" indent="yes" />
	
	<xsl:strip-space elements="*" />
	<xsl:variable name="newLine" select="'&#10;'"/>
	
	<xsl:template match="/">
	
		<xsl:for-each select="/ns1:Message/ns1:MetaData">
			<xsl:call-template name="makeMetadata">
			</xsl:call-template>
		</xsl:for-each>
	
		<xsl:for-each select="/ns1:Message/ns1:Body/ns1:persons/ns1:person">
			<xsl:call-template name="makePerson">
			</xsl:call-template>
		</xsl:for-each>
	
		<!--
		<xsl:value-of select="'METADATA'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:from" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:to" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message//ns1:MetaData//ns1:contentType" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="$newLine" />
		  -->

		<!-- civil status part  -->
		<!--
		<xsl:value-of select="'CIVILSTATUS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/@id" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:civilStatus/ns1:lastName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:civilStatus/ns1:firstName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:civilStatus/ns1:civility" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:civilStatus/ns1:birthDate" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:civilStatus/ns1:nationality" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="$newLine" />
		-->
		
		<!-- Address Part -->
		<!--
		<xsl:value-of select="'ADDRESS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:address/ns1:street" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:address/ns1:city" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="/ns1:Message/ns1:Body/ns1:persons/ns1:person/ns1:address/ns1:zipCode" />
		<xsl:text>|</xsl:text>	
		  -->
		
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
	
	<xsl:template name="makePerson">

		<!-- civil status part  -->
		<xsl:value-of select="'CIVILSTATUS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:civilStatus/ns1:lastName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:civilStatus/ns1:firstName" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:civilStatus/ns1:civility" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:civilStatus/ns1:birthDate" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:civilStatus/ns1:nationality" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="$newLine" />

		<xsl:for-each select="ns1:address">
			<xsl:call-template name="makeAddress">
			</xsl:call-template>
		</xsl:for-each>
		
		<xsl:for-each select="ns1:products/ns1:product">
			<xsl:call-template name="makeProduct">
			</xsl:call-template>
		</xsl:for-each>
		
		
	</xsl:template>

	<xsl:template name="makeAddress">

		<!-- civil status part  -->
		<xsl:value-of select="'ADDRESS'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:street" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:city" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="ns1:zipCode" />
		<xsl:text>|</xsl:text>	
		<xsl:value-of select="$newLine" />
	</xsl:template>

	<xsl:template name="makeProduct">

		<!-- civil status part  -->
		<xsl:value-of select="'PRODUCT'" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@href" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@quantity" />
		<xsl:text>|</xsl:text>
		<xsl:value-of select="@price" />
		<xsl:text>|</xsl:text>	
		<xsl:value-of select="@category" />
		<xsl:text>|</xsl:text>	
		<xsl:value-of select="@date" />
		<xsl:text>|</xsl:text>	
			
		<xsl:value-of select="$newLine" />
	</xsl:template>

		
</xsl:stylesheet>