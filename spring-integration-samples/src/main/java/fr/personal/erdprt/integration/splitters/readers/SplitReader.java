package fr.personal.erdprt.integration.splitters.readers;

import java.io.Reader;
import java.io.Writer;

import fr.personal.erdprt.integration.splitters.readers.exceptions.SplitReaderException;

public interface SplitReader {

	public abstract Reader createReader(Writer unit) throws SplitReaderException;

}