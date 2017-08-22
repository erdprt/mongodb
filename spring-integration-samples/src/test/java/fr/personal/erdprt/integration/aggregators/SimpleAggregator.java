package fr.personal.erdprt.integration.aggregators;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.annotation.Aggregator;
import org.springframework.integration.annotation.CorrelationStrategy;
import org.springframework.integration.annotation.ReleaseStrategy;

public class SimpleAggregator {
	
	private static final Logger logger	=	LoggerFactory.getLogger(SimpleAggregator.class);
	
	private Integer count			=	0;
	private Integer sequenceSize	=	0;

	@Aggregator
	public String aggregate(List<String> messages) {
		logger.debug("aggregate");
		StringBuilder builder	=	new StringBuilder("");
		
		for (String message:messages) {
			builder.append(message);
		}
		return builder.toString();
	}
	
	@CorrelationStrategy
	public Object getCorrelationKey(Message<String> message) {
		Object object		=	message.getHeaders().getCorrelationId();
		this.sequenceSize	=	message.getHeaders().getSequenceSize();
		logger.debug("sequenceSize=" + this.sequenceSize);
		logger.debug("getCorrelationKey=" + object);		
		return object;
	}
	
	@ReleaseStrategy
	public boolean canRelease(List<String> messages) {
		
		logger.debug("message size="+ messages.size());
		this.count	+=	messages.size();
		if (messages.size()==this.sequenceSize) {
			return true;
		} else {
			return false;
		}
		
		/*
		if (messages.size()==0) {
			return true;
		} else {
			return false;
		}
		*/
	}
}
