package fr.personal.erdprt.integration.splitters;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.Map;

import javax.xml.stream.XMLStreamException;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.integration.MessageHeaders;

import fr.personal.erdprt.integration.helpers.io.IOHelpers;
import fr.personal.erdprt.integration.listeners.IListener;

public class DefaultSplitterImplTest {

	private static final Logger logger	=	LoggerFactory.getLogger(DefaultSplitterImplTest.class);
	
	private static final Integer DEFAULT_BUFFER_SIZE	=	1024;
	private static final String DEFAULT_ENCODING		=	"UTF-8";
	
	
	private ApplicationContext applicationContext;
	private Splitter splitter;
	
	@Before
	public void setUp() {
		
		this.applicationContext	=	new ClassPathXmlApplicationContext("DefaultSplitterImplTest-config.xml");
		this.splitter			=	this.applicationContext.getBean("splitterDefault", Splitter.class);
	}
	
	@Test
	public void split50() throws IOException, XMLStreamException {
		
		File file				=	new File("./src/test/resources/xml/default","default_50unit.xml");
		
		Map<String, Object> headers	=	new HashMap<String, Object>();
		
		TestListener listener	=	new TestListener(50);
		this.splitter.setListener(listener);
		
		this.splitter.split(file, headers);
		
		this.splitter.split(file, headers);
		
		//this.splitter.split(file, headers);		
	}
	

	@Test
	public void split5() throws IOException, XMLStreamException {
		
		File file				=	new File("./src/test/resources/xml/default","default_5unit.xml");
		
		Map<String, Object> headers	=	new HashMap<String, Object>();
		
		TestListener listener	=	new TestListener(5);
		this.splitter.setListener(listener);
		
		this.splitter.split(file, headers);
		
		this.splitter.split(file, headers);
		
		//this.splitter.split(file, headers);		
	}

	
	public class TestListener implements IListener {
		
		private Integer sequenceSize;
		
		public TestListener(Integer sequenceSize) {
			this.sequenceSize	=	sequenceSize;
		}

		@Override
		public void register(Reader unit, Map<String, Object> headers) {
			try {
				
				IOHelpers ioHelpers	=	new IOHelpers();
				String content		=	ioHelpers.readContent(unit, DEFAULT_BUFFER_SIZE, true);
				logger.debug("content=" + content);
				if (this.sequenceSize!=null) {
					Object seqSize		=	headers.get(MessageHeaders.SEQUENCE_SIZE);
					Assert.assertNotNull(seqSize);
					Assert.assertEquals(Integer.class.getName(), seqSize.getClass().getName());
					Assert.assertEquals(seqSize, sequenceSize);
				}
				
			} catch (IOException ioe) {
				logger.error("problem when reading:", ioe);
			}
			
			
		}
		
		
	}
	
}
