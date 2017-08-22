package fr.personal.erdprt.integration.schemas;

import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.Validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.SAXException;

	public class XmlValidator {

		private static Logger logger = LoggerFactory.getLogger(XmlValidator.class.getName());

		private Map<String, Schema> schemas	=	new HashMap<String, Schema>();
		
		public XmlValidatorResult validateXml(String key, File xmlFile) {
			return validateXml(key, xmlFile, null);
		}

		public XmlValidatorResult validateXml(String key, File xmlFile, Writer writer) {
			Schema schema	=	this.schemas.get(key);
			return validateXml(xmlFile, schema, writer);
		}
		
		/**
		 * Validate xmlFile input with schemaFile xml Schema; return result in writer if not null
		 * @param xmlFile
		 * @param schemaFile
		 * @param writer
		 * @return
		 */
		private XmlValidatorResult validateXml(File xmlFile, Schema schema, Writer writer) {

			logger.info("validateXml:start");
			XmlValidatorErrorHandler errorHandler	=	new XmlValidatorErrorHandler(xmlFile.getName());
			try {
				
				StreamSource fileSource	=	new StreamSource(xmlFile);
				Validator validator		=	schema.newValidator();
				validator.setErrorHandler(errorHandler);
				
				if (writer!=null) {
					StreamResult result	=	new StreamResult(writer);
					validator.validate(fileSource, result);
				} else {
					validator.validate(fileSource);
				}
			} catch (SAXException e) {
				logger.info("validation xml for:" + xmlFile.getName() + " failed:" + e.getMessage());
			} catch (IOException e) {
				logger.info("validation xml for:" + xmlFile.getName() + " failed:" + e.getMessage());
			} finally {

				logger.info("validateXml:end");
			}
			return errorHandler.getResult();
		}
		
		public XmlValidatorResult validateXml(String key, String xml, String name) {
			return validateXml(key, xml, name, null);
		}

		public XmlValidatorResult validateXml(String key, String xml, String name, Writer writer) {
			Schema schema	=	this.schemas.get(key);
			return validateXml(xml, name, schema, writer);
		}
		
		
		private XmlValidatorResult validateXml(String xml, String name, Schema schema, Writer writer) {

			logger.info("validateXml:start");
			XmlValidatorErrorHandler errorHandler	=	new XmlValidatorErrorHandler(name);
			try {
				StringReader reader	=	new StringReader(xml);
				StreamSource fileSource	=	new StreamSource(reader);
				Validator validator		=	schema.newValidator();
				validator.setErrorHandler(errorHandler);
				
				if (writer!=null) {
					StreamResult result	=	new StreamResult(writer);
					validator.validate(fileSource, result);
				} else {
					validator.validate(fileSource);
				}
			} catch (SAXException e) {
				logger.info("validation xml for:" + name + " failed:" + e.getMessage());
			} catch (IOException e) {
				logger.info("validation xml for:" + name + " failed:" + e.getMessage());
			} finally {

				logger.info("validateXml:end");
			}
			return errorHandler.getResult();
		}
		
		
		
		public void add(String key, Schema schema) {
			this.schemas.put(key, schema);
		}
}