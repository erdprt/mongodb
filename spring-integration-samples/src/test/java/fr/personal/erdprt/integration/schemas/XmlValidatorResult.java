package fr.personal.erdprt.integration.schemas;

public class XmlValidatorResult {

	private String fileName;
	private Boolean errors			=	Boolean.FALSE;
	private Boolean warnings		=	Boolean.FALSE;
	private StringBuilder message	=	new StringBuilder("");
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Boolean isValidated() {
		return !errors;
	}
	public void setErrors(Boolean errors) {
		this.errors = errors;
	}
	public Boolean hasWarnings() {
		return this.warnings;
	}
	public Boolean hasErrors() {
		return this.errors;
	}
	
	public void setWarnings(Boolean warnings) {
		this.warnings	=	warnings;
	}
	public String getMessage() {
		return message.toString();
	}
	public void addMessage(String value) {
		this.message.append(value);
	}
	/**
		 * toString methode: creates a String representation of the object
		 * @return the String representation
		 * @author info.vancauwenberge.tostring plugin
	
		 */
		@Override
		public String toString() {
			StringBuffer buffer = new StringBuffer();
			buffer.append("XmlValidatorResult[");
			buffer.append("fileName = ").append(fileName);
			buffer.append(", errors = ").append(errors);
			buffer.append(", warnings = ").append(warnings);
			buffer.append(", message = ").append(message);
			buffer.append("]");
			return buffer.toString();
		}
}
