package fr.personal.erdprt.integration.xslt;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;

import javax.xml.XMLConstants;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.junit.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

import fr.personal.erdprt.integration.schemas.XmlValidatorErrorHandler;

public abstract class AbstractTemplateTest {

	protected static Logger logger	=	LoggerFactory.getLogger(AbstractTemplateTest.class);

	
	@Before
	public void setUp() {
		logger	=	LoggerFactory.getLogger(this.getClass());
	}
	
	protected String transform(File xslFile, File xmlFile) throws TransformerConfigurationException, TransformerException {
		
		Writer writer			=	new StringWriter();
		Result result			=	new StreamResult(writer);
		
		Transformer transformer	=	getTransformer(xslFile);
		transformer.transform(new StreamSource(xmlFile), result);
		
		logger.debug(System.getProperty("line.separator")+writer.toString());
		logger.debug("---");
		return result.toString();
	}
	
	
	protected Transformer getTransformer (File xslFile) throws TransformerConfigurationException {
		
		TransformerFactory factory 		= 	TransformerFactory.newInstance();
		factory.setErrorListener(new DefaultErrorListener());
		logger.debug("TransformerFactory class=" + factory.getClass());
	
		Transformer transformer 		= 	factory.newTransformer(new StreamSource(xslFile));
		return transformer;
	}

	
	protected void validate(String xmlContent, File schemaFile) throws IOException {
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
			errorHandler					=	new XmlValidatorErrorHandler(xmlContent);
			Reader readerXmlContent			=	new StringReader(xmlContent);
			StreamSource fileSource			=	new StreamSource(readerXmlContent);
			Validator validator				=	schema.newValidator();
			validator.setErrorHandler(errorHandler);
			validator.validate(fileSource);
		} catch (SAXException e) {
			logger.info("validation xml for:" + xmlContent + " failed:" + e.getMessage());
		} catch (IOException e) {
			logger.info("validation xml for:" + xmlContent + " failed:" + e.getMessage());
		} finally {
			if (errorHandler!=null && errorHandler.getResult()!=null && !errorHandler.getResult().isValidated()) {
				logger.info(errorHandler.getResult().getMessage());
			} else {
				logger.info("le fichier est correct");
			}
		}
		
	}
	
}
