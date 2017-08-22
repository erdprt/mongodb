package fr.personal.erdprt.integration.listeners;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringWriter;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MockListener implements IListener {
	private static Logger logger	=	LoggerFactory.getLogger(MockListener.class);
	
	private Integer bufferSize	=	1024;


	@Override
	public void register(Reader unit, Map<String, Object> headers) {
		if (headers!=null) {
			logger.debug(headers.toString());
		}
		BufferedReader bufferedReader	=	null;
		try {
			bufferedReader			=	new BufferedReader(unit);
			StringWriter writer		=	new StringWriter();
			char[] buffer			=	new char[bufferSize];
			int item;
			
			while ((item = bufferedReader.read(buffer)) != -1) {
				writer.write(buffer, 0, item);
		    }
			
			logger.info(writer.toString());
			
		} catch (IOException e) {
			logger.warn("", e);
		} finally {
			try {
				if (bufferedReader!=null) {
					bufferedReader.close();
				}
			} catch (IOException e) {
				logger.warn("",e);
			}
			try {
				if (unit!=null) {
					unit.close();
				}
			} catch (IOException e) {
				logger.warn("",e);
			}
			
		}
		
	}
	
	

}
