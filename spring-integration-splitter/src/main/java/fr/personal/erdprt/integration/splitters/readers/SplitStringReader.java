package fr.personal.erdprt.integration.splitters.readers;

import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.personal.erdprt.integration.splitters.readers.exceptions.SplitReaderException;

public class SplitStringReader implements SplitReader  {
	private static Logger logger	=	LoggerFactory.getLogger(SplitStringReader.class);
	
	private Integer bufferSize	=	1024;

	/*
	 * Implementation for in Memory
	 * @see fr.personal.erdprt.integration.splitters.readers.SplitReader#createReader(java.io.Writer)
	 */
	@Override
	public Reader createReader(Writer unit) throws SplitReaderException {
		//logger.trace("unit=" + unit.toString());
		return new StringReader(unit.toString());
	}

	public Integer getBufferSize() {
		return bufferSize;
	}

	public void setBufferSize(Integer bufferSize) {
		this.bufferSize = bufferSize;
	}


	
}
