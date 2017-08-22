package fr.personal.erdprt.integration.splitters;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.xml.stream.XMLStreamException;

import fr.personal.erdprt.integration.listeners.IListener;

public interface Splitter {

	public abstract void split(File file, Map<String, Object> headers) throws IOException, XMLStreamException;

	public abstract IListener getListener();

	public abstract void setListener(IListener listener);
}