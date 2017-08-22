package fr.personal.erdprt.integration.splitters.readers;

import java.io.Reader;
import java.io.Writer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.personal.erdprt.integration.splitters.readers.exceptions.SplitReaderException;

public class SplitFileReader implements SplitReader {
	private static Logger logger	=	LoggerFactory.getLogger(SplitFileReader.class);

	@Override
	public Reader createReader(Writer unit) throws SplitReaderException {
		//logger.debug("createReader for:" + unit.getAbsolutePath());
		Reader reader	=	null;
		//FileReader reader	=	new FileReader(unit);
		return reader;
	}
}
