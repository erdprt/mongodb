package fr.personal.erdprt.integration.mongodb;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;

import fr.personal.erdprt.springintegration.constants.FlowTracing;

public class MongoDbTest {
	
	private static final Logger logger				=	LoggerFactory.getLogger(MongoDbTest.class);
	
	private ApplicationContext applicationContext;
	private MongoTemplate mongoTemplate;
	
	@Before
	public void setUp() {
		this.applicationContext	=	new ClassPathXmlApplicationContext("mongodb-config.xml");
		this.mongoTemplate		=	this.applicationContext.getBean("mongoTemplate", MongoTemplate.class);
	}
	
	@Test
	public void findAll() {
		
		String collectionName	=	"tracing";
		String className		=	FlowTracing.class.getName();
		//Class entityClass			=	Class.forName(className);
		
		Query query						=	new Query();
		List<FlowTracing> list			=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
		
		logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
	}
	
	@Test
	public void findByStep() {
		
		String collectionName			=	"tracing";		
		
		Criteria criteria				=	new Criteria("step");
		criteria.is("incomingFileRouterChannel");
		
		Query query						=	new Query(criteria);
		
		List<FlowTracing> list			=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
		logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
		
		criteria						=	new Criteria("step");
		criteria.is("outputChannel");
		 query							=	new Query(criteria);
		list							=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
		logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
		
		criteria						=	new Criteria("step");
		criteria.is("splitDefaultChannel");
		 query							=	new Query(criteria);
		list							=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
		logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
		
		
		criteria			=	new Criteria();
		
		Criteria criteria2	=	new Criteria("step");
		criteria2.is("incomingFileRouterChannel");
		criteria.orOperator(criteria2);
		
		Criteria criteria3	=	new Criteria("step");
		criteria3.is("splitDefaultChannel");
		criteria.orOperator(criteria3);
		 query							=	new Query(criteria);
		list							=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
		logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
		
	}

	@Test
	public void findTest() {
		
		String collectionName			=	"tracing";		
		
		List<String> listDistinctTreatments		=	this.mongoTemplate.getCollection(collectionName).distinct("originalMessageId");
		logger.info("list size=" + listDistinctTreatments.size());

		// Take the first to test
		if (listDistinctTreatments.size()>0) {
			Criteria criteria				=	new Criteria("originalMessageId");
			criteria.is(listDistinctTreatments.get(0));
		
			Query query						=	new Query(criteria);
		
			List<FlowTracing> list			=	this.mongoTemplate.find(query,FlowTracing.class, collectionName);
			logger.info(FlowTracing.class.getSimpleName() + " size:" + list.size());
			
			for (FlowTracing flowHeader:list) {
				logger.info(flowHeader.toString());
			}
		}
		
	}
	
}
