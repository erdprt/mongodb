package fr.personal.erdprt.integration.handlers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;

public class SampleHandler {

	
	private static Logger logger	=	LoggerFactory.getLogger(SampleHandler.class);
	
	public Message<?> handle(Message<?> message) {
		
		logger.info("payload:" + message.getPayload());
		
		return message;
	}
}
