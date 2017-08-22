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
import java.util.Map;
import java.util.UUID;

import javax.xml.namespace.QName;
import javax.xml.stream.XMLEventReader;
import javax.xml.stream.XMLEventWriter;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.events.StartElement;
import javax.xml.stream.events.XMLEvent;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.personal.erdprt.integration.listeners.IListener;
import fr.personal.erdprt.integration.splitters.readers.SplitReader;
import fr.personal.erdprt.integration.splitters.readers.exceptions.SplitReaderException;

public class DefaultSplitterImpl implements Splitter {

	private static Logger logger	=	LoggerFactory.getLogger(DefaultSplitterImpl.class);
	
	private IListener listener;
	private SplitReader splitReader;	
	private String elementName;
	// specify xml element name containing count attribute
	private String countElementName;
	
	private Integer countElement	=	0;
	
	private InputStream inputStream;
	private XMLEventReader xmlReader;
	
	//private OutputStream outputStream;
	private Writer writer;
	private XMLEventWriter xmlEventWriter;
	
	XMLInputFactory xmlInputFactory		=	null;	
	XMLOutputFactory xmlOutputFactory	=	null;
	
	private Integer totalUnits	=	0;
	
	private CorrelationBean correlation	=	new CorrelationBean();
	
	protected List<XMLEvent> commonElements	=	new ArrayList<XMLEvent>();
	
	private void init(File file, Map<String, Object> headers) throws FileNotFoundException, XMLStreamException {
		
		this.inputStream			=	new FileInputStream(file);
		this.xmlInputFactory		=	XMLInputFactory.newInstance();
		this.xmlOutputFactory		=	XMLOutputFactory.newInstance();
		this.xmlReader				=	this.xmlInputFactory.createXMLEventReader(this.inputStream);
		this.correlation.init(headers);
		this.totalUnits				=	0;
	}
	
	private void close() throws IOException, XMLStreamException {

			if (inputStream!=null) this.inputStream.close();
			this.inputStream		=	null;
			this.xmlReader.close();
			this.xmlInputFactory	=	null;
			
			this.xmlOutputFactory	=	null;
			this.commonElements.clear();

	}
	
	/* (non-Javadoc)
	 * @see com.sgcib.fcc.rpp.fsi.integration.splitters.Splitter#split(java.io.File)
	 */
	@Override
	public void split(File file, Map<String, Object> headers) throws IOException, XMLStreamException {
		try {
			this.init(file, headers);
			this.split();
		} finally {
			this.close();
		}
	}

	public void split() throws IOException, XMLStreamException {
		
		while (this.xmlReader.hasNext()) {
			XMLEvent event = this.xmlReader.nextEvent();
			
		    if (event.isStartElement()) {
		    	if (getElementName().equalsIgnoreCase(event.asStartElement().getName().getLocalPart())) {
		    		readElement(event.asStartElement());
					this.sendNotify();
		    	} else if (getCountElementName()!=null && getCountElementName().equalsIgnoreCase(event.asStartElement().getName().getLocalPart())) {
		    			if (event.asStartElement().getAttributeByName(new QName("count"))==null) {
		    				logger.warn("didn't found count attribute");
		    			} else {
		    				String countElt	=	event.asStartElement().getAttributeByName(new QName("count")).getValue();
		    				if (countElt==null) {
		    					logger.warn("didn't found count attribute value");
		    				} else {
		    					this.countElement	=	Integer.parseInt(countElt);
		    					this.correlation.setSequenceSize(this.countElement);
		    				}
		    			}
		    		this.commonElements.add(event);
		    	} else if (this.totalUnits==0) {
		    		this.commonElements.add(event);
		    	}
		    } else if (event.isStartDocument()) {
		    	this.commonElements.add(event);
		    // Storing metadata informations
		    } else if (this.totalUnits==0) {
	    		this.commonElements.add(event);
		    }
		}		
	}
	
	public void readElement(StartElement startElement) throws IOException, XMLStreamException {
		logger.debug("readElement:" + startElement.getName().getLocalPart());
		
		this.xmlEventWriter	=	null;
		try {
			xmlEventWriter	=	createXmlWriter();
			xmlEventWriter.add(startElement);
			
			while (this.xmlReader.hasNext()) {
				XMLEvent currentEvent = this.xmlReader.nextEvent();
				xmlEventWriter.add(currentEvent);
				
				if (currentEvent.isEndElement()) {		
					if (getElementName().equalsIgnoreCase(currentEvent.asEndElement().getName().getLocalPart())) {
						logger.trace("end for:" + currentEvent.asEndElement().getName().getLocalPart());
						this.totalUnits++;
						return;
					}
				}
			}
		} finally {
			//closeWriter();
		}		
	}
	
	public void readElementCount(StartElement startElement) throws IOException, XMLStreamException {
		logger.debug("readElementCount:" + startElement.getName().getLocalPart());
		
		try {
			this.commonElements.add(startElement);
			
			while (this.xmlReader.hasNext()) {
				XMLEvent currentEvent = this.xmlReader.nextEvent();
				this.commonElements.add(currentEvent);
				
				if (currentEvent.isAttribute()) {
					logger.info("attribute count=" + currentEvent.asCharacters());
					return;
				}
			}
		} finally {
			//closeWriter();
		}		
	}
		
	private void sendNotify() throws IOException, XMLStreamException {
		try {
			if (this.listener!=null) {
				// flush content in writer
				this.closeWriter();
				//logger.debug("writer=" +this. writer.toString());
				this.listener.register(createReader(), this.correlation.nextHeader());
			}
		} catch (SplitReaderException e) {
			logger.error("Problem when creating reader:",e);
		} finally {
		}
	}
	
	public Reader createReader() throws SplitReaderException {
		if (getSplitReader()!=null) {
			return getSplitReader().createReader(this.writer);
		}
		return null;
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
		for (XMLEvent event:this.commonElements) {
			this.xmlEventWriter.add(event);
		}
		return this.xmlEventWriter;
	}
	
	public String createFilename() {
		return UUID.randomUUID().toString();
	}
	
	@Override
	public IListener getListener() {
		return listener;
	}

	@Override
	public void setListener(IListener listener) {
		this.listener = listener;
	}

	public String getElementName() {
		return elementName;
	}
	
	public void setElementName(String elementName) {
		this.elementName = elementName;
	}
	
	public SplitReader getSplitReader() {
		return splitReader;
	}

	public void setSplitReader(SplitReader splitReader) {
		this.splitReader = splitReader;
	}

	public XMLEventReader getXmlReader() {
		return xmlReader;
	}

	public void setXmlReader(XMLEventReader xmlReader) {
		this.xmlReader = xmlReader;
	}

	public String getCountElementName() {
		return countElementName;
	}

	public void setCountElementName(String countElementName) {
		this.countElementName = countElementName;
	}

}
