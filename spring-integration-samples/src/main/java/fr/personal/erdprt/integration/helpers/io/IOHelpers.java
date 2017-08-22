package fr.personal.erdprt.integration.helpers.io;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;

public class IOHelpers {

	
	public String readContent(Reader reader, int bufferSize, Boolean closeReader) throws IOException {
		
		char[] buffer			=	new char[bufferSize];
		
		InputStream inputStream	=	null;
		Writer writer			=	null;
		
		try {
			writer		=	new StringWriter();
			reader		=	new BufferedReader(reader);
			int n;
			
			while ((n = reader.read(buffer)) != -1) {
				writer.write(buffer, 0, n);
			}
			
		} finally {
			if (closeReader) {
				if (reader!=null) {
					reader.close();
				}
			}
			if (inputStream!=null) {
				inputStream.close();
			}
		}
		return writer.toString(); 
	}

	/**
	 * Read the file content and return the string representation 
	 * @param file
	 * @param bufferSize
	 * @param encoding
	 * @return String
	 * @throws IOException
	 */
	public String readContent(File file, int bufferSize, String encoding) throws IOException {
		
		char[] buffer			=	new char[bufferSize];
		
		InputStream inputStream	=	null;
		Writer writer			=	null;
		Reader reader			=	null;
		
		try {
			writer		=	new StringWriter();
			inputStream	=	new FileInputStream(file);
			reader		=	new BufferedReader(new InputStreamReader(inputStream, encoding));
			int n;
			
			while ((n = reader.read(buffer)) != -1) {
				writer.write(buffer, 0, n);
			}
			
		} finally {
			if (reader!=null) {
				reader.close();
			}
			if (inputStream!=null) {
				inputStream.close();
			}
		}
		return writer.toString(); 
	}

	public String write(File file, String content,  int bufferSize) throws IOException {
		
		char[] buffer			=	new char[bufferSize];
		
		Writer writer			=	null;
		Reader reader			=	null;
		
		try {
			writer		=	new FileWriter(file);
			reader		=	new BufferedReader(new StringReader(content));
			int n;
			
			while ((n = reader.read(buffer)) != -1) {
				writer.write(buffer, 0, n);
			}
			
		} finally {
			if (reader!=null) {
				reader.close();
			}
			if (writer!=null) {
				writer.close();
			}
		}
		return writer.toString(); 
	}

	public void writeToFile(File file, InputStream content,  int bufferSize) throws IOException {
		
		byte[] buffer				=	new byte[bufferSize];
		
		OutputStream outputStream	=	null;
		
		try {
			outputStream		=	new FileOutputStream(file);
			int n;
			
			while ((n = content.read(buffer)) != -1) {
				outputStream.write(buffer, 0, n);
			}
		} finally {
			if (outputStream!=null) {
				outputStream.close();
			}
		}
	}
	
}
