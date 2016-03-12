#include <iostream>
#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <cmath>
#include <ctime>
#include <algorithm>
#include <string>
#include <sstream>
#include <bitset>
#include <vector>
#include <map>
#include <set>
#include <list>
#include <queue>
#include <stack>
#define LL long long
#define LD long double
#define INF 1000000000
#define INFll 1000000000000000000ll
#define mp make_pair
#define pb push_back
#define Vi vector<int>
#define VI Vi::iterator
#define Si set<int>
#define SI Si::iterator
#define Mi map<int, int>
#define MI Mi::iterator
#define MX 111111
#define lbt(x) ((x) & (-(x)))
using namespace std;

LL f1, f2, f3, f4, f5, f6, f12, f13, f65, f64, tmp, s;
LL s1[MX], s2[MX];
int n, a[MX], size;
Mi M;

struct arr{
	LL a[MX];
	void add(int posi, LL dlt){
		for (; posi <= n; posi += lbt(posi)) a[posi] += dlt;
	}
	LL sum(int posi){
		LL ss = 0;
		for (; posi; posi -= lbt(posi)) ss += a[posi];
		return ss;
	}
	LL sum(int x, int y){
		return sum(y) - sum(x - 1);
	}
}p1, p2, q1, q2;

void print(LL x, LL y){
	printf("%d.", (int)(x / y));
	for (int i = 0; i < 20; i++){
		x = x % y * 10;
		printf("%d", (int)(x / y));
	}
	printf("\n");
}

int main(){
	freopen("shape.in", "r", stdin);
	freopen("shape.out", "w", stdout);
	
	scanf("%d", &n);
	for (int i = 1; i <= n; i++){
		scanf("%d", &a[i]);
		M[ a[i] ] = 0;
	}
	for (MI ii = M.begin(); ii != M.end(); ii++)
		ii->second = ++size;
	for (int i = 1; i <= n; i++)
		a[i] = M[ a[i] ];
	for (int i = 1; i <= n; i++){
		p2.add(a[i], 1);
		q2.add(a[i], s2[ a[i] ]++);
	}
	for (int i = 1; i <= n; i++){
		p2.add(a[i], -1);
		q2.add(a[i], -(--s2[ a[i] ]));
		
		f1 += p1.sum(a[i] - 1) * p2.sum(a[i] + 1, size);
		tmp = p2.sum(a[i] + 1, size);
		f12 += tmp * (tmp - 1) / 2 - q2.sum(a[i] + 1, size);
		tmp = p1.sum(a[i] - 1);
		f13 += tmp * (tmp - 1) / 2 - q1.sum(a[i] - 1);
		
		f6 += p1.sum(a[i] + 1, size) * p2.sum(a[i] - 1);
		tmp = p2.sum(a[i] - 1);
		f65 += tmp * (tmp - 1) / 2 - q2.sum(a[i] - 1);
		tmp = p1.sum(a[i] + 1, size);
		f64 += tmp * (tmp - 1) / 2 - q1.sum(a[i] + 1, size);
		
		
		p1.add(a[i], 1);
		q1.add(a[i], s1[ a[i] ]++);
	}
	
	f2 = f12 - f1;
	f3 = f13 - f1;
	f5 = f65 - f6;
	f4 = f64 - f6;
	s = f1 + f2 + f3 + f4 + f5 + f6;
	print(f1, s);
	print(f2, s);
	print(f3, s);
	print(f4, s);
	print(f5, s);
	print(f6, s);
	return 0;
}

