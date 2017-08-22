package fr.personal.erdprt.integration.splitters;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.integration.Message;
import org.springframework.integration.splitter.AbstractMessageSplitter;

import fr.personal.erdprt.integration.splitters.readers.exceptions.SplitReaderException;

public class StaxBasicSplitterImpl extends AbstractMessageSplitter  {

	private static Logger logger	=	LoggerFactory.getLogger(StaxBasicSplitterImpl.class);
	
	private String elementName;
	
	private InputStream inputStream;
	private XMLEventReader xmlReader;
	
	//private OutputStream outputStream;
	private Writer writer;
	private XMLEventWriter xmlEventWriter;
	
	XMLInputFactory xmlInputFactory		=	null;	
	XMLOutputFactory xmlOutputFactory	=	null;
	
	private List<String> units			=	new ArrayList<>();
	
	private void init(File file) throws FileNotFoundException, XMLStreamException {
		
		this.inputStream			=	new FileInputStream(file);
		this.xmlInputFactory		=	XMLInputFactory.newInstance();
		this.xmlOutputFactory		=	XMLOutputFactory.newInstance();
		this.xmlReader				=	this.xmlInputFactory.createXMLEventReader(this.inputStream);
	}
	
	private void close() throws IOException, XMLStreamException {

			if (inputStream!=null) this.inputStream.close();
			this.inputStream		=	null;
			this.xmlReader.close();
			this.xmlInputFactory	=	null;
			
			this.xmlOutputFactory	=	null;
	}
	
	@Override
	protected Object splitMessage(Message<?> message) {
		logger.debug("file=" + message.getPayload());
		
		this.units	=	new ArrayList<String>();
		try {
			File file	=	(File)message.getPayload();
			logger.debug("split file:" + file);
			this.init(file);
			this.split();
			return this.units;
		} catch (Exception e) {
			throw new SplitReaderException(e);
		} finally {
			try  {
				this.close();
			} catch (Exception e) {
				throw new SplitReaderException(e);
			}
		}
	}

	public void split() throws IOException, XMLStreamException {
		
		while (this.xmlReader.hasNext()) {
			XMLEvent event = this.xmlReader.nextEvent();
			
		    if (event.isStartElement()) {
		    	if (getElementName().equalsIgnoreCase(event.asStartElement().getName().getLocalPart())) {
		    		readElement(event.asStartElement());
		    	}
		    }			
		}
	}
	
	public void readElement(StartElement startElement) throws IOException, XMLStreamException {
		logger.debug("readElement:" + startElement.getName().getLocalPart());
		try {
			this.xmlEventWriter	=	null;
				xmlEventWriter	=	createXmlWriter();
				xmlEventWriter.add(startElement);
				
				while (this.xmlReader.hasNext()) {
					XMLEvent currentEvent = this.xmlReader.nextEvent();
					xmlEventWriter.add(currentEvent);
					
					if (currentEvent.isEndElement()) {		
						if (getElementName().equalsIgnoreCase(currentEvent.asEndElement().getName().getLocalPart())) {
							logger.trace("end for:" + currentEvent.asEndElement().getName().getLocalPart());
							return;
						}
					}
				}
		} finally {
			this.units.add(this.writer.toString());
			this.closeWriter();
		}
	}
	
	/**
	 * Close xmlEventWriter, it implies flushing content in writer
	 * @throws IOException
	 * @throws XMLStreamException
	 */
	public void closeWriter() throws IOException, XMLStreamException {
		logger.trace("closeWriter");
		
		if (this.xmlEventWriter!=null) this.xmlEventWriter.close();
		this.xmlEventWriter	=	null;
		
		if (this.writer!=null) this.writer.close();
		//this.writer	=	null;
	}
	
	public XMLEventWriter createXmlWriter() throws FileNotFoundException, XMLStreamException {
		logger.trace("createXmlWriter");
		
		this.writer				=	new StringWriter();
		this.xmlEventWriter		=	this.xmlOutputFactory.createXMLEventWriter(this.writer);
		return this.xmlEventWriter;
	}
	
	public String createFilename() {
		return UUID.randomUUID().toString();
	}
	
	public String getElementName() {
		return elementName;
	}
	
	public void setElementName(String elementName) {
		this.elementName = elementName;
	}
	
	public XMLEventReader getXmlReader() {
		return xmlReader;
	}

	public void setXmlReader(XMLEventReader xmlReader) {
		this.xmlReader = xmlReader;
	}
}
