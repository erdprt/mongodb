<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="2.0"
	xmlns:ns1="http://erdprt.org/PersonStructure"
	xmlns:ns2="http://erdprt.org/DefaultStructure"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="ns2:Message" mode="document">
			<xsl:with-param name="elementName" select="'Message'" as="xs:string" />
			<xsl:with-param name="elementNameSpace" select="'http://erdprt.org/PersonStructure'" as="xs:string" />
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="ns2:Message" mode="document">
		
		<xsl:param name="elementName" as="xs:string" required="yes" />
		<xsl:param name="elementNameSpace" as="xs:string" required="yes" />

		<xsl:element name="Message" namespace="{$elementNameSpace}">
		
			<xsl:for-each select="/ns2:Message/ns2:MetaData">
				<xsl:call-template name="makeMetadata">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />				
				</xsl:call-template>
			</xsl:for-each>
			
			<xsl:for-each select="/ns2:Message/ns2:Body">
				<xsl:call-template name="makeBody">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />				
				</xsl:call-template>
			</xsl:for-each>

		</xsl:element>

	</xsl:template>
	
	<xsl:template name="makeMetadata">
	
		<xsl:param name="elementNameSpace" as="xs:string" required="yes" />
			
		<xsl:element name="MetaData" namespace="{$elementNameSpace}">
			<xsl:element name="from" namespace="{$elementNameSpace}">
				<xsl:value-of select="ns2:from" />
			</xsl:element>
			<xsl:element name="to" namespace="{$elementNameSpace}">
				<xsl:value-of select="ns2:to" />
			</xsl:element>
			<xsl:element name="contentType" namespace="{$elementNameSpace}">
				<xsl:value-of select="ns2:contentType" />
			</xsl:element>
		</xsl:element>
		
	</xsl:template>
	
	<xsl:template name="makeBody">
	
		<xsl:param name="elementNameSpace" />
	
		<xsl:element name="Body" namespace="{$elementNameSpace}">

			<xsl:for-each select="ns2:persons">
				<xsl:call-template name="makePersons">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />				
				</xsl:call-template>
			</xsl:for-each>
			
		</xsl:element>
	</xsl:template>

	<xsl:template name="makePersons">
		
		<xsl:param name="elementNameSpace" />
		
		<xsl:element name="persons" namespace="{$elementNameSpace}">
			<xsl:attribute name="count">
				<xsl:value-of select="'1'"></xsl:value-of>
			</xsl:attribute>
			
			<xsl:for-each select="ns2:person">
				<xsl:call-template name="makePerson">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />
				</xsl:call-template>
			</xsl:for-each>
		</xsl:element>
		
	</xsl:template>

	<xsl:template name="makePerson">
		
		<xsl:param name="elementNameSpace" />	
	
		<xsl:element name="person" namespace="{$elementNameSpace}">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="lastName">
				<xsl:value-of select="ns2:civilStatus/ns2:lastName"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="firstName">
				<xsl:value-of select="ns2:civilStatus/ns2:firstName"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="civility">
				<xsl:value-of select="ns2:civilStatus/ns2:civility"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="birthDate">
				<xsl:value-of select="ns2:civilStatus/ns2:birthDate"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="nationality">
				<xsl:value-of select="ns2:civilStatus/ns2:nationality"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="street">
				<xsl:value-of select="ns2:address/ns2:street"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="city">
				<xsl:value-of select="ns2:address/ns2:city"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="zipCode">
				<xsl:value-of select="ns2:address/ns2:zipCode"></xsl:value-of>
			</xsl:attribute>
		</xsl:element>
		
	</xsl:template>

</xsl:stylesheet>