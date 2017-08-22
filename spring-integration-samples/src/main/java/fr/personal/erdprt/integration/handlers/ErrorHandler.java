package fr.personal.erdprt.integration.handlers;

import java.io.PrintWriter;
import java.io.StringWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.support.MessageBuilder;

public class ErrorHandler {

	
	private static Logger logger	=	LoggerFactory.getLogger(ErrorHandler.class);
	
	public Message<?> handle(Message<?> message) {
		
		logger.info("error handle class  :" + message.getPayload().getClass());		
		logger.info("error handle payload:" + message.getPayload());
		
		logger.trace(showHeaders(message));
		
		String newPayload	=	null;	
		
		if (message.getPayload() instanceof Throwable) {
			newPayload	=	getStacktrace((Throwable)message.getPayload());
			
			MessageBuilder<?> messageBuilder	=	MessageBuilder.withPayload(newPayload);
			messageBuilder.copyHeaders(message.getHeaders());
			return messageBuilder.build();
		} else {
			Object object	=	message.getPayload();
			logger.info("class=" + message.getPayload().getClass());
		}
		return message;
		
	}
	
	private String showHeaders(Message<?> message) {
		StringBuilder builder	=	new StringBuilder("headers:");
		if (message!=null && message.getHeaders()!=null) {
			for (String key:message.getHeaders().keySet()) {
				builder.append("{key,value}={" +key +"," + message.getHeaders().get(key)+ "}");
			}
		}
		return builder.toString();
	}
	

	public String getStacktrace(Throwable th) {

		StringWriter stringWriter	=	new StringWriter();
		PrintWriter printWriter		=	new PrintWriter(stringWriter);
		th.printStackTrace(printWriter);
		return stringWriter.toString();
	}

}
