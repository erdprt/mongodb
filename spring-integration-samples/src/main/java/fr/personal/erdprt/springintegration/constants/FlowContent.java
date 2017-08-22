package fr.personal.erdprt.springintegration.constants;

public class FlowContent {
	
	private String messageId;
	private String content;
	
	public String getMessageId() {
		return messageId;
	}
	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "FlowContent [messageId=" + messageId + ", content=" + content
				+ "]";
	}
	
}
