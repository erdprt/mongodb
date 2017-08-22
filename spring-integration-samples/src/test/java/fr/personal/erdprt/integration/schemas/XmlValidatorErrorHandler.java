package fr.personal.erdprt.integration.schemas;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

public class XmlValidatorErrorHandler implements ErrorHandler {
	private static Logger logger	=	LoggerFactory.getLogger(XmlValidatorErrorHandler.class.getName());

	private static final String LINE_SEPARATOR		=	"\n";
	private static final String FIELD_SEPARATOR		=	"=";
	private static final String COLUMN_SEPARATOR	=	";";
	private XmlValidatorResult result			=	new XmlValidatorResult();
	
	public XmlValidatorErrorHandler(String identifier) {
		this.result.setFileName(identifier);
	}
	
	@Override
	public void warning(SAXParseException exception) throws SAXException {
		this.result.setWarnings(Boolean.TRUE);
		buildField(exception,"warning");		
	}

	@Override
	public void error(SAXParseException exception) throws SAXException {
		this.result.setErrors(Boolean.TRUE);
		buildField(exception,"error");
	}

	@Override
	public void fatalError(SAXParseException exception) throws SAXException {
		this.result.setErrors(Boolean.FALSE);
		buildField(exception,"fatalError");
	}
	
	private void buildField(SAXParseException exception, String level) {
		StringBuilder builder				=	new StringBuilder("");
		builder.append("level=").append(level).append(COLUMN_SEPARATOR);
		builder.append("message").append(FIELD_SEPARATOR).append(exception.getMessage()).append(COLUMN_SEPARATOR);
		builder.append("lineNumber").append(FIELD_SEPARATOR).append(exception.getLineNumber()).append(COLUMN_SEPARATOR);
		builder.append("colunmNumber").append(FIELD_SEPARATOR).append(exception.getColumnNumber()).append(COLUMN_SEPARATOR);
		builder.append(LINE_SEPARATOR);
		this.result.addMessage(builder.toString());
	}
	
	public XmlValidatorResult getResult() {
		return this.result;
	}

}
