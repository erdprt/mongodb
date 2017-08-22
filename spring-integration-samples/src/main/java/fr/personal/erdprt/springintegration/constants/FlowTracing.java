package fr.personal.erdprt.springintegration.constants;

import java.util.Date;

public class FlowTracing {
	
	private String originalMessageId;	
	private String parentMessageId;
	private String messageId;
	private String fileType;
	private String step;
	private String originalFileName;
	private Date startDate;	
	private Date endDate;
	private Date processingStartDate;
	private Date processingEndDate;
	
	
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	
	public Date getProcessingStartDate() {
		return processingStartDate;
	}
	public void setProcessingStartDate(Date processingStartDate) {
		this.processingStartDate = processingStartDate;
	}
	public Date getProcessingEndDate() {
		return processingEndDate;
	}
	public void setProcessingEndDate(Date processingEndDate) {
		this.processingEndDate = processingEndDate;
	}
	
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	
	public String getParentMessageId() {
		return parentMessageId;
	}
	public void setParentMessageId(String parentMessageId) {
		this.parentMessageId = parentMessageId;
	}
	public String getMessageId() {
		return messageId;
	}
	public void setMessageId(String messageId) {
		this.messageId = messageId;
	}
	
	public String getOriginalMessageId() {
		return originalMessageId;
	}
	public void setOriginalMessageId(String originalMessageId) {
		this.originalMessageId = originalMessageId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return "FlowHeader [originalMessageId=" + originalMessageId
				+ ", parentMessageId=" + parentMessageId + ", messageId="
				+ messageId + ", fileType=" + fileType + ", step=" + step
				+ ", originalFileName=" + originalFileName + ", startDate="
				+ startDate + ", processingStartDate=" + processingStartDate
				+ ", processingEndDate=" + processingEndDate + "]";
	}

	public FlowTracing duplicate() {
		FlowTracing flowHeader	=	new FlowTracing();
		flowHeader.setOriginalMessageId(getOriginalMessageId());
		flowHeader.setParentMessageId(getParentMessageId());
		flowHeader.setMessageId(getMessageId());
		flowHeader.setStartDate(getStartDate());
		flowHeader.setEndDate(flowHeader.getEndDate());
		flowHeader.setFileType(getFileType());
		flowHeader.setOriginalFileName(getOriginalFileName());
		flowHeader.setStartDate(getStartDate());
		flowHeader.setProcessingStartDate(getProcessingStartDate());
		flowHeader.setProcessingEndDate(getProcessingEndDate());
		flowHeader.setStep(getStep());
		
		return flowHeader;
	}
}
