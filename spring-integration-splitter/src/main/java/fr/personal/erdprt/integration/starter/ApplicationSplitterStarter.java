package fr.personal.erdprt.integration.starter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationSplitterStarter {

	private static Logger logger	=	LoggerFactory.getLogger(ApplicationSplitterStarter.class);
	private ApplicationContext context;
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		new ApplicationSplitterStarter().proceed();

	}
	
	public void proceed(){
		init();
		
		((ClassPathXmlApplicationContext)this.context).start();
	}
	
	public void init()  {
		this.context	=	new ClassPathXmlApplicationContext("spring-integration-config.xml");
	}
}
