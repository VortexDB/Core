package core.time.schedule;

/**
 *  Schedule that launches periodicaly
 */
class PeriodicSchedule implements ISchedule {
    /**
     *  Offset date
     */
    public final offset : Date;

	/**
	 *  Constructor
	 */
	public function new(offset : Date, period : TimeSpan) {
        this.offset = offset;
    }

	/**
	 * Return next start
	 * @return TimeSpan
	 */
	public function nextStart():TimeSpan {
		return null;
	}
}
