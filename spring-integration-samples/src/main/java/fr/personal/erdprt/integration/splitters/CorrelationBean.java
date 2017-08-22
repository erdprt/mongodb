package fr.personal.erdprt.integration.splitters;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.integration.MessageHeaders;

public class CorrelationBean {

	private Map<String, Object> headers;
	private String correlationId;
	private Integer currentSequenceNumber	=	0;
	private Integer sequenceSize			=	0;
	
	
	public Integer getNextSequenceNumber() {
		return (++currentSequenceNumber);
	}
	
	public Integer getSequenceSize() {
		return sequenceSize;
	}

	public void setSequenceSize(Integer sequenceSize) {
		this.sequenceSize = sequenceSize;
	}

	public String getCorrelationId() {
		return correlationId;
	}
	
	public void init(Map<String, Object> headers) {
		this.headers				=	headers;
		this.correlationId			=	UUID.randomUUID().toString();
		this.currentSequenceNumber	=	0;
	}
	
	public Map<String, Object> nextHeader() {
		Map<String, Object> newHeaders	=	new HashMap<>();
		
		for (String key:this.headers.keySet()) {
			newHeaders.put(key, this.headers.get(key));
		}
		newHeaders.put(MessageHeaders.CORRELATION_ID, getCorrelationId());
		newHeaders.put(MessageHeaders.SEQUENCE_NUMBER, getNextSequenceNumber());
		if (getSequenceSize()!=null && getSequenceSize()!=0) {
			newHeaders.put(MessageHeaders.SEQUENCE_SIZE, getSequenceSize());
		} else {
			newHeaders.put(MessageHeaders.SEQUENCE_SIZE, -1);
		}
		
		return newHeaders;
	}
	
	
}
