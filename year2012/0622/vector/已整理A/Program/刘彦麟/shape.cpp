#include <cstdio>
#include <cstring>
#include <algorithm>
#include <cmath>
#include <iostream>
#include <cctype>

using namespace std;

const int MXN = 100010;

int n;
int a[MXN];
int c[10],sum;
long double tmp;
double ans;

inline void gi(int &x) {
	char ch; while (ch = getchar(), ch<'0' || ch>'9');
	x = ch - '0'; while (ch = getchar(), ch>='0' && ch<='9') x = x * 10 + ch - '0';
}

int main() {
	freopen("shape.in","r",stdin);
	freopen("shape.out","w",stdout);
	
	gi(n);
	for (int i = 1;i<=n;i++) gi(a[i]);
	
	memset(c,0,sizeof(c));
	for (int i = 1;i<=n;i++)
		for (int j = i + 1;j<=n;j++)
			for (int k = j + 1;k<=n;k++) {
				if (a[i]<a[j] && a[j]<a[k]) c[1]++;
				if (a[i]<a[k] && a[k]<a[j]) c[2]++;
				if (a[j]<a[i] && a[i]<a[k]) c[3]++;
				if (a[k]<a[i] && a[i]<a[j]) c[4]++;
				if (a[j]<a[k] && a[k]<a[i]) c[5]++;
				if (a[k]<a[j] && a[j]<a[i]) c[6]++;
			}
	sum = 0; for (int i = 1;i<=6;i++) sum += c[i];
	for (int i = 1;i<=6;i++) {
		tmp = 100000000000000000000.0 * c[i] / (1.00000000000000000000 * sum);
		//cout.setf(ios::fixed);
		//cout << tt << endl;
		//cout << tmp << endl;
		tmp = floor(tmp) / 100000000000000000000.0;
		//ans = (double)tmp;
		//printf("%.20lf\n",tmp);
		cout.setf(ios::fixed);
		//cout.precius(20);
		cout << tmp << endl;
	}
	
	return 0;
}
