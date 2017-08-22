package fr.personal.erdprt.integration.generators;

import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.file.FileNameGenerator;

import fr.personal.erdprt.springintegration.constants.IGlobalHeaders;

public class UUIDFileNameGenerator implements FileNameGenerator {

	private Logger logger	=	LoggerFactory.getLogger(UUIDFileNameGenerator.class);
	
	@Override
	public String generateFileName(Message<?> message) {
		String fileName	=	null;
		
		String extensionFile	=	message.getHeaders().get(IGlobalHeaders.EXTENSION_FILE, String.class);
		if (extensionFile!=null) {
			extensionFile	=	"." + extensionFile;
		} else {
			extensionFile	=	"";
		}
		fileName	=	UUID.randomUUID().toString() + extensionFile;
		logger.trace("generateFileName:" + fileName);
		return fileName;
	}

}
