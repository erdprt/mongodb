package fr.personal.erdprt.integration.helpers.dates;

import java.util.Calendar;
import java.util.Date;

public class DateHelpers {

	/**
	 * Used to centralize date
	 * could be be changed further
	 * @return java.util.Calendar
	 */
	public Calendar getDateCalendar() {
		return Calendar.getInstance();
	}
	
	public Date getDate() {
		return Calendar.getInstance().getTime();
	}
	
}
