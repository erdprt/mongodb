package fr.personal.erdprt.integration.concurrent;

import java.util.concurrent.BlockingQueue;

import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

public class CustomThreadPoolTaskExecutor extends ThreadPoolTaskExecutor {

	@Override
	protected BlockingQueue<Runnable> createQueue(int queueCapacity) {
		return new CustomLinkedBlockingQueue(queueCapacity);
	}

	
}
