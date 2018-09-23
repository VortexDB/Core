package core.time.schedule;

/**
 *  Schedule that launches periodicaly
 */
class PeriodicSchedule implements ISchedule {
	/**
	 * Start DateTime to count launch time
	 */
	private var offsetDate : DateTime;

    /**
     *  Offset time of launch
     */
    public final offset : TimeSpan;

	/**
	 * Launch period
	 */
	public final period : TimeSpan;

	/**
	 *  Constructor
	 */
	public function new(period : TimeSpan, ?offset : TimeSpan) {
		if (offset == null) {
			this.offset = new TimeSpan({});
		} else {
			this.offset = offset;
		}
        
		this.period = period;
    }

	/**
	 * Return next start
	 * @return TimeSpan
	 */
	public function nextStart():TimeSpan {
		var now = DateTime.now();
		if (offsetDate == null) {
            offsetDate = new DateTime(now.year, now.month, now.day);
            offsetDate = offsetDate + offset;
		}

		var periodSeconds = Math.floor(period.totalSeconds);

		var between = now - offsetDate;
		var parts  = Math.floor(between.totalSeconds / periodSeconds);
		offsetDate = offsetDate + new TimeSpan({seconds: periodSeconds * parts});
		var startDate = offsetDate + period;
		var res = startDate - now;
		return res;
	}
}
