package fr.personal.erdprt.integration.schemas;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

public class XmlValidatorTest {

	private static final Logger logger	=	LoggerFactory.getLogger(XmlValidatorTest.class);
	
	
	@Before
	public void setUp() {
		
	}
	
	
	@Test
	public void testPerson() throws IOException {
		
		File xmlFile		=	new File("./src/test/resources/xml/default","default_1unit_validation.xml");
		File schemaFile		=	new File("./src/main/resources/schemas","PersonStructure.xsd");
		validate(xmlFile, schemaFile);
	}

	@Test
	public void testProduct() throws IOException {
		
		File xmlFile		=	new File("./src/test/resources/xml/product","product_1unit_validation.xml");
		File schemaFile		=	new File("./src/main/resources/schemas","ProductStructure.xsd");
		validate(xmlFile, schemaFile);
	}
	
	
	public void validate(File xmlFile, File schemaFile) throws IOException {
		String schemaFactoryClassName			=	"com.sun.org.apache.xerces.internal.jaxp.validation.XMLSchemaFactory";
		XmlValidatorErrorHandler errorHandler	=	null;
		
		try {
			StreamSource schemaSource		=	new StreamSource(schemaFile);
			// Creation d'une fabrique d'instance
			SchemaFactory schemaFactory		=	SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI, 
																		schemaFactoryClassName, 
																		this.getClass().getClassLoader());
			// Creation d'une instance Schema pour la validation ci-dessous
			Schema schema					=	schemaFactory.newSchema(schemaSource);
			
			// Instanciation d'un gestionnaire d'error, pour illustration
			errorHandler					=	new XmlValidatorErrorHandler(xmlFile.getAbsolutePath());
			StreamSource fileSource			=	new StreamSource(xmlFile);
			Validator validator				=	schema.newValidator();
			validator.setErrorHandler(errorHandler);
			validator.validate(fileSource);
		} catch (SAXException e) {
			logger.info("validation xml for:" + xmlFile.getName() + " failed:" + e.getMessage());
		} catch (IOException e) {
			logger.info("validation xml for:" + xmlFile.getName() + " failed:" + e.getMessage());
		} finally {
			if (errorHandler!=null && errorHandler.getResult()!=null && !errorHandler.getResult().isValidated()) {
				logger.info(errorHandler.getResult().getMessage());
			} else {
				logger.info("le fichier est correct");
			}
		}
		
	}

	public void builReport(XmlValidatorResult result) throws IOException {
		logger.info("Debut de la generation du rapport");
		Calendar calendar		=	Calendar.getInstance();
		SimpleDateFormat dateF	=	new SimpleDateFormat("yyyy-MM-dd-HH");
		String prefix			=	dateF.format(calendar.getTime());
		FileWriter writer		=	null;	
		try {
			File sourceFile		=	new File(result.getFileName());
			File reportFile		=	new File("./rapport-" + prefix + "_"+ sourceFile.getName());
			logger.info("generation du rapport dans:" + reportFile.getAbsolutePath());
			writer				=	new FileWriter(reportFile);
			writer.write(result.getMessage());
			writer.flush();
		} finally {
			if (writer!=null) {
				writer.close();
			}
		}
	}
	
	
}
