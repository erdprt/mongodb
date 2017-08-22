package fr.personal.erdprt.integration.handlers;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.MessageChannel;
import org.springframework.integration.support.MessageBuilder;

import fr.personal.erdprt.integration.helpers.io.IOHelpers;
import fr.personal.erdprt.integration.listeners.IListener;
import fr.personal.erdprt.integration.splitters.advanced.Splitter;


public class AdvancedSplitterHandler implements IListener {

	private static Logger logger	=	LoggerFactory.getLogger(AdvancedSplitterHandler.class);
	
	private Integer bufferSize;
	private String fileType;
	private Splitter splitter;
	private MessageChannel messageChannel;
	
	
	public void handle(Message<File> message) throws Exception {
		
		File file	=	message.getPayload();
		logger.debug("handle file:" + file);
		getSplitter().setListener(this);
		getSplitter().split(file, getHeaders(message));
		
	}

	@Override
	public void register(Reader unit, Map<String, Object> headers) {

		try {
			IOHelpers ioHelpers	=	new IOHelpers();
			String content		=	ioHelpers.readContent(unit, bufferSize, true);
			logger.debug("content=" + content);
			
			MessageBuilder<String> messageBuilder	=	MessageBuilder.withPayload(content);
			messageBuilder.setHeader("fileType", getFileType());
			messageBuilder.copyHeaders(headers);
			getMessageChannel().send(messageBuilder.build());
			
		} catch (IOException e) {
			logger.error("problem when reading content:",e);
		}
		
	}
	
	public Map<String, Object> getHeaders(Message<File> message) {
		Map<String, Object> headers	=	new HashMap<String, Object>();
		
		for (String key:message.getHeaders().keySet()) {
			headers.put(key, message.getHeaders().get(key));
		}
		//message.getHeaders().
		return headers;
	}

	public Splitter getSplitter() {
		return splitter;
	}


	public void setSplitter(Splitter splitter) {
		this.splitter = splitter;
	}


	public MessageChannel getMessageChannel() {
		return messageChannel;
	}


	public void setMessageChannel(MessageChannel messageChannel) {
		this.messageChannel = messageChannel;
	}

	public Integer getBufferSize() {
		return bufferSize;
	}

	public void setBufferSize(Integer bufferSize) {
		this.bufferSize = bufferSize;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	
}
