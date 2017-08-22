package fr.personal.erdprt.integration.splitters;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.integration.Message;
import org.springframework.integration.MessageChannel;
import org.springframework.integration.support.MessageBuilder;

/**
 * Unit test for simple App.
 */
public class StaxDefaultSplitterImplTest {
	
	private static final Logger logger	=	LoggerFactory.getLogger(StaxDefaultSplitterImplTest.class);
	private ApplicationContext applicationContext;
	
	@Before
	public void setUp() {
		this.applicationContext	=	new ClassPathXmlApplicationContext("spring-integration-config.xml");
	}
	
	@Test
	public void testClass() {
		
		File file							=	new File("./src/test/resources","default_10unit.xml");
		MessageBuilder<?> messageBuilder	=	MessageBuilder.withPayload(file);
		Message<?> message					=	messageBuilder.build();
		
		StaxBasicSplitterImpl staxSplitter	=	new StaxBasicSplitterImpl();
		staxSplitter.setElementName("person");
		Object object	=	staxSplitter.splitMessage(message);
		Assert.assertNotNull(object);
		Assert.assertEquals(ArrayList.class, object.getClass());
		
		List<String> units	=	(List<String>)object;
		Assert.assertEquals(10, units.size());
	}
	
	@Test
	public void testBean() {
		
		File file							=	new File("./src/test/resources","default_10unit.xml");
		
		MessageChannel messageChannel		=	this.applicationContext.getBean("incomingStaxChannel",MessageChannel.class);
		MessageBuilder<File> messageBuilder	=	MessageBuilder.withPayload(file);
		messageChannel.send(messageBuilder.build());
		
		
	}
	
}
