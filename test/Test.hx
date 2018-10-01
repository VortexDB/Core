package test;

import utest.ui.Report;
import utest.Runner;

/**
 *  For launching tests
 */
class Test {
	static function main() {
		var runner = new Runner();
		runner.addCase(new StringHelperCase());
		runner.addCase(new IterableHelperCase());
		runner.addCase(new DateTimeCase());
		runner.addCase(new TimeSpanCase());
		runner.addCase(new PeriodicScheduleCase());
		runner.addCase(new TcpListenerCase());
		runner.addCase(new HashSetCase());
		runner.addCase(new SerialPortCase());
		runner.addCase(new FutureCase());
		runner.addCase(new BinaryDataCase());
		Report.create(runner);
		runner.run();
	}
}
