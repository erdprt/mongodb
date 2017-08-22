<?xml version='1.0' encoding='UTF-8' ?>
<xsl:stylesheet version="2.0"
	xmlns:ns1="http://erdprt.org/ProductStructure"
	xmlns:ns2="http://erdprt.org/DefaultStructure"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="ns2:Message" mode="document">
			<xsl:with-param name="elementName" select="'Message'" as="xs:string" />
			<xsl:with-param name="elementNameSpace" select="'http://erdprt.org/ProductStructure'" as="xs:string" />
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
			<xsl:for-each select="ns2:persons/ns2:person/ns2:products">
				<xsl:call-template name="makeProducts">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />				
				</xsl:call-template>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	
	<xsl:template name="makeProducts">
		
		<xsl:param name="elementNameSpace" />
		
		<xsl:element name="products" namespace="{$elementNameSpace}">
			<xsl:attribute name="count">
				<xsl:value-of select="@count"></xsl:value-of>
			</xsl:attribute>
			
			<xsl:for-each select="ns2:product">
				<xsl:call-template name="makeProduct">
					<xsl:with-param name="elementNameSpace" select="$elementNameSpace" />
				</xsl:call-template>
			</xsl:for-each>
		</xsl:element>
		
	</xsl:template>
	
	
	<xsl:template name="makeProduct">
		
		<xsl:param name="elementNameSpace" />	
	
		<xsl:element name="product" namespace="{$elementNameSpace}">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="quantity">
				<xsl:value-of select="@quantity"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="category">
				<xsl:value-of select="@category"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="date">
				<xsl:value-of select="@date"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="price">
				<xsl:value-of select="@price"></xsl:value-of>
			</xsl:attribute>
		</xsl:element>
		
	</xsl:template>
	
	<!--
	<xsl:template name="makeMetadata">
	
		<xsl:element name="MetaData">
			<xsl:element name="from">
				<xsl:value-of select="ns2:from" />
			</xsl:element>
			<xsl:element name="to">
				<xsl:value-of select="ns2:to" />
			</xsl:element>
			<xsl:element name="contentType">
				<xsl:value-of select="ns2:contentType" />
			</xsl:element>
		</xsl:element>
		
	</xsl:template>
	
	<xsl:template name="makeBody">
	
		<xsl:element name="Body">

			<xsl:for-each select="ns2:persons/ns2:person/ns2:products">
				<xsl:call-template name="makeProducts">
				</xsl:call-template>
			</xsl:for-each>
			
		</xsl:element>
	</xsl:template>

	<xsl:template name="makeProducts">
		
		<xsl:element name="products">
			<xsl:attribute name="count">
				<xsl:value-of select="@count"></xsl:value-of>
			</xsl:attribute>
			
			<xsl:for-each select="ns2:product">
				<xsl:call-template name="makeProduct">
				</xsl:call-template>
			</xsl:for-each>
		</xsl:element>
		
	</xsl:template>

	<xsl:template name="makeProduct">
	
		<xsl:element name="product">
			<xsl:attribute name="count">
				<xsl:value-of select="@count"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="quantity">
				<xsl:value-of select="@quantity"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="category">
				<xsl:value-of select="@category"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="date">
				<xsl:value-of select="@date"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="price">
				<xsl:value-of select="@price"></xsl:value-of>
			</xsl:attribute>
		</xsl:element>
		
	</xsl:template>
	-->

</xsl:stylesheet>