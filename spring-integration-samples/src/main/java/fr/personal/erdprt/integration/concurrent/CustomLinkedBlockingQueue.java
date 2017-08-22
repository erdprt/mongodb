package fr.personal.erdprt.integration.concurrent;

import java.util.concurrent.LinkedBlockingQueue;

public class CustomLinkedBlockingQueue extends LinkedBlockingQueue<Runnable> {

	public CustomLinkedBlockingQueue(int capacity) {
		super(capacity);
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean offer(Runnable runnable) {
		try {
			super.put(runnable);
		} catch (InterruptedException e) {
			return false;
		}
		return true;
	}

}
