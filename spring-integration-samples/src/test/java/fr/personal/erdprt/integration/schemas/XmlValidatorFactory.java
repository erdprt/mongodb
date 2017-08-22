package fr.personal.erdprt.integration.schemas;

import java.io.File;
import java.util.Iterator;
import java.util.Map;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

public class XmlValidatorFactory {
	private static final Logger logger	=	LoggerFactory.getLogger(XmlValidatorFactory.class.getName());

	private Map<String, String> schemaFiles;
	private String schemaFactoryClassName;
	private String schemaDirectory;
	
	
	public XmlValidator create() throws SAXException {
		
		XmlValidator xmlValidator	=	new XmlValidator();
		for (Iterator<String> iterator=schemaFiles.keySet().iterator();iterator.hasNext();) {
			String key			=	iterator.next();
			String value		=	this.schemaFiles.get(key);
			File  schemaFile	=	new File(getSchemaDirectory(),value);
			
			StreamSource schemaSource	=	new StreamSource(schemaFile);
			
			SchemaFactory schemaFactory	=	SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI, 
																		schemaFactoryClassName, 
																		this.getClass().getClassLoader());
			
			//SchemaFactory schemaFactory	=	SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			Schema schema				=	schemaFactory.newSchema(schemaSource);
			logger.info("add key=" + key +";schemaFactory=" + schemaFactory.getClass()+";schema=" + schema.getClass());
			xmlValidator.add(key, schema);
		}
		return xmlValidator;
	}
	
	public String getSchemaDirectory() {
		return schemaDirectory;
	}

	public void setSchemaDirectory(String schemaDirectory) {
		this.schemaDirectory = schemaDirectory;
	}

	public Map<String, String> getSchemaFiles() {
		return schemaFiles;
	}
	public void setSchemaFiles(Map<String, String> schemaFiles) {
		this.schemaFiles = schemaFiles;
	}
	public String getSchemaFactoryClassName() {
		return schemaFactoryClassName;
	}
	public void setSchemaFactoryClassName(String schemaFactoryClassName) {
		this.schemaFactoryClassName = schemaFactoryClassName;
	}
	
	
	
}
