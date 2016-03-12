#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <climits>
#include <cassert>
#include <ctime>
#include <string>
#include <vector>
#include <deque>
//#include <cmath>
#include <list>
#include <set>
#include <map>
#include <queue>
#include <stack>
#include <utility>
#include <algorithm>
using namespace std;

#define Rep(i, a, b) for(int i(a); i <= (b); ++i)
#define Til(i, a, b) for(int i(a); i >= (b); --i)
#define Foru(i, a, b) for(int i(a); i < (b); ++i)
#define Ford(i, a, b) for(int i(a); i > (b); --i)

#define Debug(x) cerr << #x << " = " << (x) << endl
#define Debug2(x, y) cerr << #x << " = " << (x) << ", " << #y << " = " << (y) << endl

#define INF 1000000000
#define It iterator
#define EPS (1e-9)

#define Pow2(x) (1 << (x))
#define Contain(a, x) ( bool( (a) & (Pow2(x)) ) )

typedef long long LL;
typedef unsigned long long ULL;
typedef pair<int, int> pii;

template <class T> inline bool Up(T &a, const T &b) { if(a < b) { a = b; return true; } return false; }
template <class T> inline bool Down(T &a, const T &b) { if(a > b) { a = b; return true; } return false; }

inline int getus() { int a, f; while(a = fgetc(stdin), !('0' <= a && a <= '9')); a -= '0'; while(f = fgetc(stdin), '0' <= f && f <= '9') a = a * 10 + f - '0'; return a; }
inline int getint() { int a, f, t; while(f = fgetc(stdin), f != '-' && !('0' <= f && f <= '9')); a = (f == '-') ? (0) : (f - '0'); while(t = fgetc(stdin), '0' <= t && t <= '9') a = a * 10 + t - '0'; return f == '-' ? -a : a; }
/*
double Gbase[MAXN][MAXN], *G[MAXN], res[MAXN];

#define Zero(x) (fabs(x) < EPS)

void CalcMat() {
	memset(res, 0, sizeof(res));
	int RestBegin = 1;
	Rep(i_th, 1, N) {
		int MaxRow = 0;
		Rep(row, RestBegin, N) if(!Zero( G[row][i_th] ))
			if(!MaxRow || fabs(G[row][i_th]) > fabs(G[MaxRow][i_th]))
				MaxRow = row;
		if(!MaxRow) continue;
		swap(G[MaxRow], G[RestBegin]);
		MaxRow = RestBegin;
		
		Rep(row, 1, N) if(row != MaxRow && !Zero(G[row][i_th])) {
			double rate = G[row][i_th] / G[MaxRow][i_th];
			Rep(col, 0, N)
				G[row][col] -= G[MaxRow][col] * rate;
		}
		++RestBegin;
	}
	Rep(row, 1, N) if(!Zero(G[row][0])) {
		int i_th = 1;
		while(i_th <= N)
			if(!Zero(G[row][i_th]))
				break;
			else ++i_th;
		if(i_th > N) {
			puts("Wrong!");
			continue;
		}
		res[i_th] = G[row][0] / G[row][i_th];
	}
}

void Work() {
	CalcMat();
	Rep(i, 1, N)
		printf("%.2lf ", res[i]);
	puts("");
	double tmp = 0;
	Rep(i, 1, N) {
		double t;
		scanf("%lf", &t);
		tmp += res[i] * t;
//		printf("%.2lf %.2lf\n", res[i], t);
	}
	printf("%.2f\n", tmp);
}

void Init() {
	N = getus();
	Rep(i, 1, N) {
		G[i] = Gbase[i];
		Rep(j, 1, N)
			G[i][j] = getint();
		G[i][0] = getint();
	}
}
*/

#define MAXN 100

struct Mat {
	LL G[5][5];
	int n, m;
/*	void See() const {
		Debug2(n, m);
		Rep(i, 1, n) {
			Rep(j, 1, m)
				fprintf(stderr, "%lld ", G[i][j]);
			fprintf(stderr, "\n");
		}
	}
*/	Mat() { memset(this, 0, sizeof(Mat)); }
} Init_M, Trans_M, E_M;

int N, P;

inline Mat operator * (const Mat &a, const Mat &b) {
	Mat ret;
	memset(&ret, 0, sizeof(Mat));
	ret.n = a.n; ret.m = b.m;
//	Debug2(ret.n, ret.m);
//	assert(a.m == b.n);
	Rep(i, 1, ret.n) Rep(j, 1, ret.m) {
		LL &res = ret.G[i][j] = 0;
		Rep(k, 1, a.m)
			res = (res + a.G[i][k] * b.G[k][j]) % P;
	}
//	a.See();
//	b.See();
//	ret.See();
	
	return ret;
}

void MatPow(int K) {
	Mat res = E_M;
	for(int i = 30; i >= 0; --i) {
		res = res * res;
		if(K & Pow2(i))
			res = res * Trans_M;
	}
	Trans_M = res;
}

void Work() {
	if(N == 1) printf("%d\n", 1 % P);
	else if(N == 2) printf("%d\n", 3 % P);
	else if(N == 3) printf("%d\n", 12 % P);
	else if(N == 4) printf("%d\n", 51 % P);
	else {
		Init_M.n = 1; Init_M.m = 4;
		Init_M.G[1][1] = 51 % P;
		Init_M.G[1][2] = 12 % P;
		Init_M.G[1][3] = 3 % P;
		Init_M.G[1][4] = 1 % P;
		
		Trans_M.n = Trans_M.m = 4;
		Trans_M.G[1][1] = 7 % P;
		Trans_M.G[1][2] = 1 % P;
		Trans_M.G[2][1] = (-14 % P + P) % P;
		Trans_M.G[2][3] = 1 % P;
		Trans_M.G[3][1] = 11 % P;
		Trans_M.G[3][4] = 1 % P;
		Trans_M.G[4][1] = (-2 % P + P) % P;
		
		E_M.n = E_M.m = 4;
		E_M.G[1][1] = 1 % P;
		E_M.G[2][2] = 1 % P;
		E_M.G[3][3] = 1 % P;
		E_M.G[4][4] = 1 % P;
		
//		Init_M.See();
//		Trans_M.See();
//		E_M.See();
		
		MatPow(N - 4);
		Init_M = Init_M * Trans_M;
		printf("%d\n", int(Init_M.G[1][1] % P));
	}
}

void Init() {
	N = getus(); P = getus();
}

int main() {
	freopen("brick.in", "r", stdin);
	freopen("brick.out", "w", stdout);
	
	Init();
	Work();
	
	return 0;
}
