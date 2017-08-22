package fr.personal.erdprt.integration.handlers;

import java.io.File;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.support.MessageBuilder;

import fr.personal.erdprt.springintegration.constants.FlowTracing;
import fr.personal.erdprt.springintegration.constants.IFlowHeader;

public class CheckFileHandler {

	private static Logger logger	=	LoggerFactory.getLogger(CheckFileHandler.class);
	
	public Message<File> handle(Message<File> message) {
			File file	=	message.getPayload();
			logger.trace("receive file=" + file.getName() + ";fileType=" + getFileType(file));
		
			FlowTracing flowHeader				=	message.getHeaders().get(IFlowHeader.FLOW_HEADER, FlowTracing.class);
			MessageBuilder<File> messageBuilder	=	MessageBuilder.withPayload(file);
			
			flowHeader			=	flowHeader.duplicate();
			flowHeader.setFileType(getFileType(file));
			flowHeader.setOriginalFileName(file.getName());

			messageBuilder.setHeader(IFlowHeader.FLOW_HEADER, flowHeader);
			messageBuilder.setHeader(IFlowHeader.FILE_TYPE_HEADER, flowHeader.getFileType());
			
			return messageBuilder.build();
			
	}
	
	private String getFileType(File file) {
		if (file.getName().toLowerCase().startsWith("default")) {
			return "default";
		} else if (file.getName().toLowerCase().startsWith("person")) {
				return "person";
		} else if (file.getName().toLowerCase().startsWith("product")) {
			return "product";
		} else {
			return "unknown";
		}
	}

}
