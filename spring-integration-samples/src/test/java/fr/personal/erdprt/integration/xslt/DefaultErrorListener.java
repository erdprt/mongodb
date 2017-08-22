package fr.personal.erdprt.integration.xslt;

import javax.xml.transform.ErrorListener;
import javax.xml.transform.TransformerException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DefaultErrorListener implements ErrorListener {

	private static final Logger logger	=	LoggerFactory.getLogger(DefaultErrorListener.class);	
	
	@Override
	public void warning(TransformerException exception)
			throws TransformerException {
		logger.info("warning:" + exception.getMessage());

	}

	@Override
	public void error(TransformerException exception)
			throws TransformerException {
		logger.info("error:" + exception.getMessage());

	}

	@Override
	public void fatalError(TransformerException exception)
			throws TransformerException {
		logger.info("fatalError:" + exception.getMessage());

	}

}
