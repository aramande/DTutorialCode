module util.stat;

interface Stat {
	void accumulate(double x);
	void postprocess();
	double getResult();
}

abstract class IncrementalStat : Stat{
	protected double result;
	void postprocess() {}
	double getResult() {
		return result;
	}
}

class Min : IncrementalStat{
	this(){
		result = double.max;
	}
	void accumulate(double x) {
		if (x < result) {
			result = x;
		}
	}
}

class Max : IncrementalStat{
	this(){
		result = double.min;
	}
	void accumulate(double x) {
		if (x > result) {
			result = x;
		}
	}
}

class Sum : IncrementalStat{
	this(){
		result = 0;
	}
	void accumulate(double x){
		result += x;
	}
}

class Average : IncrementalStat{
	uint items;

	this(){
		result = 0;
		items = 0;
	}

	override void postprocess(){
		if(items)
			result /= items;
	}

	void accumulate(double x){
		result += x;
		++items;
	}
}
