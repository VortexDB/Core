package core.async.fiber;

import core.utils.exceptions.TimeoutExeption.TimeoutException;
import java.vm.Thread;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Channel for communitcation between fibers
 * Not buffered
 * TODO: cross-platform
 */
class Channel<T> {
	/**
	 * Mutex?
	 */
	private var lock:ReentrantLock;

	/**
	 * For waiting event
	 */
	private var dataCond:Condition;

	/**
	 * Result of fiber
	 */
	private var result:T;

	public function new() {
		lock = new ReentrantLock();
		dataCond = lock.newCondition();
	}

	/**
	 * Send data
	 * @param v 
	 */
	public function send(v:T) {
		lock.lock();
		result = v;
		dataCond.signal();
		lock.unlock();
	}

	/**
	 * Read data with timeout in milliseconds
	 * @return T
	 */
	public function read(?timeout:Int):T {        
		lock.lock();
        Scheduler.instance.notifyLock(Thread.current());
        if (result == null) {
			if (timeout == null) {
		    	dataCond.await();
			} else {
				dataCond.await(timeout, java.util.concurrent.TimeUnit.MILLISECONDS);
				throw new TimeoutException("Channel read timeout");
			}
        }
		var res = result;
		result = null;

        lock.unlock();		
		return res;
	}
}
