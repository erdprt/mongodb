package fr.personal.erdprt.integration.xslt;

import java.io.File;
import java.io.IOException;
import javax.xml.transform.TransformerException;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class XsltTemplateDefaultTest extends AbstractTemplateTest {

	private static final Logger logger	=	LoggerFactory.getLogger(XsltTemplateDefaultTest.class);
	
	@Test
	public void testDefaultToProduct()  throws TransformerException, IOException {
		
		File xslFile			=	new File("./src/main/resources/xsl","defaultToProduct.xsl");		
		File xmlFile			=	new File("./src/test/resources/xml/default","default_1unit.xml");
		
		String xmlResult		=	transform(xslFile, xmlFile);
		
		File schemaFile			=	new File("./src/main/resources/schemas","ProductStructure.xsd");
		validate(xmlResult.trim(), schemaFile);

	}

	@Test
	public void testDefaultToPerson()  throws TransformerException, IOException {
		
		File xslFile			=	new File("./src/main/resources/xsl","defaultToPerson.xsl");		
		File xmlFile			=	new File("./src/test/resources/xml/default","default_1unit.xml");
		
		String xmlResult		=	transform(xslFile, xmlFile);
		
		File schemaFile			=	new File("./src/main/resources/schemas","PersonStructure.xsd");
		validate(xmlResult, schemaFile);
	}

	@Test
	public void testDefaultToCsv()  throws TransformerException {
		
		File xslFile			=	new File("./src/main/resources/xsl","defaultToCsv.xsl");		
		File xmlFile			=	new File("./src/test/resources/xml/default","default_1unit.xml");
		transform(xslFile, xmlFile);
	}
	
}
