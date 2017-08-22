package fr.personal.erdprt.integration.xslt;

import java.io.File;
import javax.xml.transform.TransformerException;
import org.junit.Test;

public class XsltTemplateProductTest extends AbstractTemplateTest {

	@Test
	public void testProductToCsv()  throws TransformerException {
		
		File xslFile			=	new File("./src/main/resources/xsl","productToCsv.xsl");		
		File xmlFile			=	new File("./src/test/resources/xml/product","product_1unit.xml");
		transform(xslFile, xmlFile);
	}
	
}
