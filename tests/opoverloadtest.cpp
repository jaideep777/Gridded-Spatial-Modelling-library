#include <iostream>
#include <vector>
#include <string>
#include <cmath>
using namespace std;

//class var;

//class var_proxy{
//	
//	friend class var;
//	public:
//		var_proxy( var &v, int _i, int _j) : var_instance(v), i(_i), j(_j){}
//		var_proxy operator=(float val);
//		var& var_instance;
//	
//	private:
//		int i, j;
//};

//var_proxy var_proxy::operator=(float val){
//	var_instance.v[i*3+j] = val;
//	return *this;
//}

class var{
	public:
	vector <float> v;

	var(){};
	var(int i, int j){v.push_back(i); v.push_back(j);};
	
	float& operator () (int i, int j) {return v[3*i+j];};
	float& operator [] (int i) {return v[i];}; 

	// var_proxy& operator () (int i, int j);
//	var operator = (const var_proxy& vp){
//		v[3*i+j] = vp.var_instance.v[3*i+j];
//	}

	void print(){for (int i=0; i<v.size(); ++i) cout << v[i] << " "; cout << '\n'; };
};


//float * var::operator () (int i, int j){
//	return &v[i*3+j];
//}


int main(){
	
	vector <float> a(6,1); a[1]=2; a[2]=3; a[3]=11; a[4]=22; a[5]=33;
	var s(3,2); s.print();
	s.v = a; s.print();
	
	cout << s(1,1) << endl; 

	float c = log(s[4]);
	cout << c << '\n';
	c = 77;
	cout << c << '\n';

	s[4] = 88;
	cout << s(1,1) << endl; 

	cout << s[4] << endl; 
	
}
