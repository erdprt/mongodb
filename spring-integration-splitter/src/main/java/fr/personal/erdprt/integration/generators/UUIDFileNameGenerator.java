package fr.personal.erdprt.integration.generators;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.file.FileNameGenerator;

public class UUIDFileNameGenerator implements FileNameGenerator {

	private Logger logger	=	LoggerFactory.getLogger(UUIDFileNameGenerator.class);
	
	@Override
	public String generateFileName(Message<?> message) {
		String fileName	=	null;
		
		String extensionFile	=	".xml";
		fileName	=	UUID.randomUUID().toString() + extensionFile;
		logger.trace("generateFileName:" + fileName);
		return fileName;
	}

}
