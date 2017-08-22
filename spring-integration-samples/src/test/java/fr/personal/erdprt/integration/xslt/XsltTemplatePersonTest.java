package fr.personal.erdprt.integration.xslt;

import java.io.File;
import javax.xml.transform.TransformerException;
import org.junit.Test;

public class XsltTemplatePersonTest extends AbstractTemplateTest {

	@Test
	public void testPersonToCsv()  throws TransformerException {
		
		File xslFile			=	new File("./src/main/resources/xsl","personToCsv.xsl");		
		File xmlFile			=	new File("./src/test/resources/xml/person","person_1unit.xml");
		transform(xslFile, xmlFile);
	}
}
