package fr.personal.erdprt.integration.interceptors;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.integration.Message;
import org.springframework.integration.MessageChannel;
import org.springframework.integration.channel.AbstractMessageChannel;
import org.springframework.integration.channel.interceptor.ChannelInterceptorAdapter;
import org.springframework.integration.support.MessageBuilder;

import fr.personal.erdprt.integration.helpers.dates.DateHelpers;
import fr.personal.erdprt.springintegration.constants.FlowContent;
import fr.personal.erdprt.springintegration.constants.FlowTracing;
import fr.personal.erdprt.springintegration.constants.IFlowHeader;

public class TracingInterceptor extends ChannelInterceptorAdapter {
	
	private static final Logger logger	=	LoggerFactory.getLogger(TracingInterceptor.class);
	
	private MongoTemplate mongoTemplate;
	private List<String> endComponents;

	@Override
	public Message<?> preSend(Message<?> message, MessageChannel channel) {
		logger.debug(showComponentName(channel));
		logger.trace(showHeaders(message));
		logger.trace(showMessagePayload(message));
		message	=	register(message, channel);
		
		return super.preSend(message, channel);
	}

	/*
	public void postSend(Message<?> message, MessageChannel channel, boolean sent) {
		logger.debug(showComponentName(channel));
		logger.trace(showHeaders(message));
		logger.trace(showMessagePayload(message));		

		super.postSend(message, channel, sent);
	}


	public boolean preReceive(MessageChannel channel) {
		//logger.debug(showComponentName(channel));

		return super.preReceive(channel);
	}

	public Message<?> postReceive(Message<?> message, MessageChannel channel) {
		logger.debug(showComponentName(channel));
		logger.trace(showHeaders(message));
		logger.trace(showMessagePayload(message));		
		return super.postReceive(message, channel);
	}
	*/
	private String showHeaders(Message<?> message) {
		StringBuilder builder	=	new StringBuilder("headers:");
		if (message!=null && message.getHeaders()!=null) {
			for (String key:message.getHeaders().keySet()) {
				builder.append("{key,value}={" +key +"," + message.getHeaders().get(key)+ "}");
			}
		}
		return builder.toString();
	}
	
	private String showMessagePayload(Message<?> message) {
		StringBuilder builder	=	new StringBuilder("body:");
		if (message!=null) {
			if (message.getPayload() instanceof Throwable) {
				logger.debug("throwable");
				builder.append(((Throwable)message.getPayload()).getMessage());
			} else {
				builder.append(message.getPayload());
			}
		}
		return builder.toString();
	}

	private String showComponentName(MessageChannel messageChannel) {
		StringBuilder builder	=	new StringBuilder("component name=");
		builder.append(getComponentName(messageChannel));
		return builder.toString();
	}
	
	public Message<?> register(Message<?> message, MessageChannel channel) {
		try {
		String step					=	getComponentName(channel);
		logger.trace("register trace for componentName=" + step);
		String messageId			=	message.getHeaders().getId().toString();
		DateHelpers dateHelpers		=	new DateHelpers();
		
		FlowTracing flowHeader			=	message.getHeaders().get(IFlowHeader.FLOW_HEADER, FlowTracing.class);
		// If not exists: create it
		if (flowHeader==null) {
			logger.trace("header flowHeader does not exist: create");
			flowHeader	=	new FlowTracing();
			flowHeader.setStep(step);
			flowHeader.setParentMessageId(messageId);
			flowHeader.setMessageId(messageId);
			flowHeader.setOriginalMessageId(messageId);
			flowHeader.setProcessingStartDate(dateHelpers.getDate());
			flowHeader.setStartDate(dateHelpers.getDate());
			
			MessageBuilder<?> messageBuilder	=	MessageBuilder.withPayload(message.getPayload());
			messageBuilder.copyHeaders(message.getHeaders());
			messageBuilder.setHeader(IFlowHeader.FLOW_HEADER, flowHeader);
			
			message	=	messageBuilder.build();
		} else {
		flowHeader					=	flowHeader.duplicate();
		if (!messageId.equalsIgnoreCase(flowHeader.getMessageId())) {
			flowHeader.setParentMessageId(flowHeader.getMessageId());
		}
		
		flowHeader.setStep(step);
		flowHeader.setMessageId(messageId);
		flowHeader.setProcessingEndDate(dateHelpers.getDate());
		
		logger.trace("{componentName,messageId}={" +  step + "," + message.getHeaders().getId() + "}");

		if (getEndComponents().contains(step)) {
			flowHeader.setEndDate(dateHelpers.getDate());
			if (message.getPayload() instanceof String) {
				FlowContent flowContent	=	new FlowContent();
				flowContent.setMessageId(flowHeader.getMessageId());
				flowContent.setContent((String)message.getPayload());
				getMongoTemplate().save(flowContent, IFlowHeader.UNIT_COLLECTION_NAME);
			}
			
			
		}
		
		getMongoTemplate().save(flowHeader, IFlowHeader.TRACING_COLLECTION_NAME);
		
		// Reset settings for next step
		flowHeader.setProcessingEndDate(null);
		flowHeader.setProcessingStartDate(dateHelpers.getDate());
		}
		return message;
		} catch (Throwable th) {
			logger.error("tracing error:", th);
			throw th;
		}
	}

	public MongoTemplate getMongoTemplate() {
		return mongoTemplate;
	}

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}
	
	public List<String> getEndComponents() {
		return endComponents;
	}

	public void setEndComponents(List<String> endComponents) {
		this.endComponents = endComponents;
	}

	private String getComponentName(MessageChannel channel) {
		String componentName		=	((AbstractMessageChannel)channel).getComponentName();
		return componentName;
	}
	
	
}
