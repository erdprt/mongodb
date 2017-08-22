package fr.personal.erdprt.integration.listeners;

import java.io.Reader;
import java.util.Map;

public interface IListener {

	public abstract void register(Reader unit, Map<String, Object> headers);
	
}
