package core.async.fiber;

import java.vm.Thread;

/**
 * Schedule for workers that launches fibers
 */
class Scheduler {
	/**
	 * Instance of schedule
	 */
	public static final instance = new Scheduler();

	/**
	 * Current idle worker
	 */
	private var currentWorker:SchedulerWorker;

	/**
	 * List of all workers
	 */
	private var workers:List<SchedulerWorker>;

	/**
	 * Constructor
	 */
	public function new() {
		workers = new List<SchedulerWorker>();
		var nWorker = new SchedulerWorker();
		workers.add(nWorker);
	}

	/**
	 * Notify that thread is locked by channel
	 * TODO: slooooooow
	 * @param thread
	 */
	public function notifyLock(thread:Thread) {
		// Start new schedule and assign it jobs of blocked worker
		for (worker in workers) {
			if (worker.backThread == thread) {
				worker.isBlocked = true;
				var nWorker = new SchedulerWorker();
				// BAD. 
				for (node in worker.fibers)
					nWorker.fibers.add(node);

				worker.fibers.clear();				
				workers.add(nWorker);
				nWorker.start();
				break;
			}
		}
	}

	/**
	 * Add new fiber to idle worker
	 * @param fiber
	 */
	public function add(fiber:Fiber) {	
		if (currentWorker == null || currentWorker.isBlocked) {		
			for (worker in workers) {
				if (!worker.isBlocked) {
					currentWorker = worker;
					break;
				}
			}
		}

		if (currentWorker == null) {
			currentWorker = new SchedulerWorker();
			workers.add(currentWorker);
		}
		
		currentWorker.add(fiber);
		currentWorker.start();
	}
}
