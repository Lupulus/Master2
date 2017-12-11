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
    _result.clear();

    for (int i = 1; i < p.size(); i++) {
        _result.push_back(p[i-1] * 0.75 + p[i] * 0.25);
        _result.push_back(p[i-1] * 0.25 + p[i] * 0.75);
    }
    if (isClosed()) {
        _result.push_back(p[p.size()-1] * 0.75 + p[0] * 0.25);
        _result.push_back(p[p.size()-1] * 0.25 + p[0] * 0.75);
    }

}

void SubdivCurve::dynLevinIter(const vector<Vector3> &p) {
    _result.clear();

    for (int i = 1; i < p.size() - 2; i++) {
        _result.push_back(p[i]);
        _result.push_back(- (p[i+2] + p[i-1]) * 0.0625 + (p[i+1] + p[i]) * 0.5625);
    }
    if (isClosed()) {
        _result.push_back(p[p.size()-2]);
        _result.push_back(- (p[0] + p[p.size()-3]) * 0.0625 + (p[p.size()-1] + p[p.size()-2]) * 0.5625);
        _result.push_back(p[p.size()-1]);
        _result.push_back(- (p[1] + p[p.size()-2]) * 0.0625 + (p[0] + p[p.size()-1]) * 0.5625);
        _result.push_back(p[0]);
        _result.push_back(- (p[2] + p[p.size()-1]) * 0.0625 + (p[1] + p[0]) * 0.5625);
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


