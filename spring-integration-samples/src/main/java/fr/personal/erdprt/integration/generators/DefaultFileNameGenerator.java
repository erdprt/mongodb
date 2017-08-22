package fr.personal.erdprt.integration.generators;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.file.FileNameGenerator;

public class DefaultFileNameGenerator implements FileNameGenerator {

	private Logger logger	=	LoggerFactory.getLogger(DefaultFileNameGenerator.class);
	private Integer count	=	0;
	
	@Override
	public String generateFileName(Message<?> message) {
		logger.debug("generateFileName:");
		count++;
		
		String originalFilename	=	(String)message.getHeaders().get("originalFilename");
		String processDateTime	=	(String)message.getHeaders().get("processDateTime");
		
		if (processDateTime==null) {
			processDateTime	=	String.valueOf(System.currentTimeMillis());
		}
		String response	=	"";
		if (originalFilename!=null) {
			response	=	count + "_" +processDateTime + "_" + originalFilename ;
		} else {
			response	=	UUID.randomUUID().toString() + ".xml";
		}
		logger.debug("response=" + response);
		return response;
	}
	
	

}
