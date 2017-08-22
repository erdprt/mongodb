package fr.personal.erdprt.integration.starter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationStarter {

	private static Logger logger	=	LoggerFactory.getLogger(ApplicationStarter.class);
	private ApplicationContext context;
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		new ApplicationStarter().proceed();

	}
	
	public void proceed(){
		init();
		
		((ClassPathXmlApplicationContext)this.context).start();
		logger.info("classpath=" + System.getProperty("java.class.path"));		
		
	}
	
	
	public void init()  {
		this.context	=	new ClassPathXmlApplicationContext("spring-integration-config.xml");
	}
	

}
