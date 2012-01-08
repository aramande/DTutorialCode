import std.stdio;
import std.exception;
import util.stat;

void main(string[] args){
	Stat[] stats;
	foreach (arg; args[1 .. $]) {
		auto newStat = cast(Stat) Object.factory("util.stat." ~ arg);
		enforce(newStat, "Invalid statistics function: " ~ arg);
		stats ~= newStat;
	}
	for (double x; readf(" %f ", &x) == 1; ) {
		foreach (s; stats) {
			s.accumulate(x);
		}
	}
	foreach (s; stats) {
		s.postprocess();
		writeln(s.getResult());
	}
}
