package fr.personal.erdprt.integration.mongodb;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DivTest {
	private static final Logger logger	=	LoggerFactory.getLogger(DivTest.class);

	
	@Test
	public void testStringWriter() throws IOException {
		logger.info("test");
		StringWriter stringWriter	=	new StringWriter();
		stringWriter.append("aaaaa");
		stringWriter.append("bbbbb");
		logger.info("stringWriter=" + stringWriter.toString());
		stringWriter.close();
		logger.info("stringWriter=" + stringWriter.toString());
		
		CharArrayWriter charArrayWriter	=	new CharArrayWriter();
		charArrayWriter.append("aaaaa");
		charArrayWriter.append("bbbbb");
		logger.info("charArrayWriter=" + charArrayWriter.toString());
		
	}
	
	@Test
	public void testRandom() {
		
		String[] countries	=	new String[] {"france", "england", "Irland", "USA", "italy", "unknown"};
		Random random		=	new Random();
		
		for (Integer index=0;index<10;index++) {
			logger.info("" +countries[random.nextInt(countries.length)]);
		}
		
	}
	
	@Test
	public void tesTimestamp() {
		//1356983227114
		
		Calendar calendar	=	Calendar.getInstance();
		calendar.setTimeInMillis(1356984147647L);
		SimpleDateFormat dateFormat	=	new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		logger.info("date=" + dateFormat.format(calendar.getTime()));
		
	}
}
