#include "SubdivCurve.h"
#include <cmath>
#include <iostream>

#include "Vector3.h"
#include "Matrix4.h"

using namespace std;
using namespace p3d;

SubdivCurve::~SubdivCurve() {
}

SubdivCurve::SubdivCurve() {
  _nbIteration=1;
  _source.clear();
  _result.clear();

}


void SubdivCurve::addPoint(const p3d::Vector3 &p) {
  _source.push_back(p);
}

void SubdivCurve::point(int i,const p3d::Vector3 &p) {
  _source[i]=p;
}


void SubdivCurve::chaikinIter(const vector<Vector3> &p) {
  /* TODO : one iteration of Chaikin : input = p, output = you must set the vector _result (vector of Vector3)
   */
    _result.clear();
    if(isClosed()){
        _result.resize(2*p.size());
        _result[_result.size()-2] = 0.75*p[p.size()-1] + 0.25*p[0];
        _result[_result.size()-1] = 0.25*p[p.size()-1] + 0.75*p[0];
    }
    else
        _result.resize(2*p.size()-2);

    for(int unsigned i=0;i<p.size()-1;i++){
            _result[2*i] = 0.75*p[i] + 0.25*p[i+1];
            _result[2*i+1] = 0.25*p[i] + 0.75*p[i+1];
    }

}

void SubdivCurve::dynLevinIter(const vector<Vector3> &p) {
  /* TODO : one iteration of DynLevin : input = p, output = you must set the vector _result (vector of Vector3)
   */
  _result.clear();
  _result.resize(2*p.size());
  int len = p.size();

  for(int unsigned i=1;i<p.size()-1;i++){
          _result[2*i] = p[i];
          _result[2*i+1] = (-1)/16.0* (p[(i+2)%len] + p[i-1]) + 9/16.0*(p[i+1]+p[i]) ;
  }
}


void SubdivCurve::chaikin() {
  if (_source.size()<2) return;
  vector<Vector3> current;
  _result=_source;
  for(int i=0;i<_nbIteration;++i) {
    current=_result;
    chaikinIter(current);
  }
}

void SubdivCurve::dynLevin() {
  if (_source.size()<2) return;
  if (!isClosed()) return;
  vector<Vector3> current;
  _result=_source;
  for(int i=0;i<_nbIteration;++i) {
    current=_result;
    dynLevinIter(current);
  }
}


