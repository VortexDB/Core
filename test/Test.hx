package test;

import utest.ui.Report;
import utest.Runner;

/**
 *  For launching tests
 */
class Test {
	static function main() {
		var runner = new Runner();
		runner.addCase(new TimeSpanCase());
		Report.create(runner);
		runner.run();
	}
}
