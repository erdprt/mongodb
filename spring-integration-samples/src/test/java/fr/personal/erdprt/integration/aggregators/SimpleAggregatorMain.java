package fr.personal.erdprt.integration.aggregators;

import java.io.File;
import java.io.IOException;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.integration.MessageChannel;
import org.springframework.integration.support.MessageBuilder;

import fr.personal.erdprt.integration.helpers.io.IOHelpers;

public class SimpleAggregatorMain {

	private ApplicationContext context;

	public static void main(String[] args) throws IOException {
		SimpleAggregatorMain instance	=	new SimpleAggregatorMain();
		instance.init();
		//instance.testGood();
		instance.testBad();
		
	}
	
	public void init() {
		this.context	=	new ClassPathXmlApplicationContext("chain-aggregator-test.xml");
	}
	
	public void testGood() throws IOException {
		
		File file		=	new File("./src/test/resources/xml/default","default_5unit.xml");
		//String content	=	new IOHelpers().readContent(file, 1024, "UTF-8");
		
		MessageChannel messageChannel			=	this.context.getBean("splitDefaultChannel",MessageChannel.class);
		MessageBuilder<File> messageBuilder	=	MessageBuilder.withPayload(file);
		messageChannel.send(messageBuilder.build());
	}
	
	public void testBad() throws IOException {
		
		File file		=	new File("./src/test/resources/xml/default","default_5unit_bad.xml");
		//String content	=	new IOHelpers().readContent(file, 1024, "UTF-8");
		
		MessageChannel messageChannel			=	this.context.getBean("splitDefaultChannel",MessageChannel.class);
		MessageBuilder<File> messageBuilder	=	MessageBuilder.withPayload(file);
		messageChannel.send(messageBuilder.build());
	}
	
}
