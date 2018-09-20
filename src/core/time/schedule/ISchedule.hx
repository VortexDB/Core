package core.time.schedule;

/**
 *  Interface for schedule that returns next start TimeSpan
 */
interface ISchedule {
    /**
     * Returns next start time
     * @return TimeSpan
     */
    function nextStart() : TimeSpan;
}