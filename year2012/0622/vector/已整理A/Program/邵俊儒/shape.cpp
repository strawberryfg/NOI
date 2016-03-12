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

#define Pow2(x) (1 << (x))
#define Contain(a, x) ( bool( (a) & (Pow2(x)) ) )

typedef long long LL;
typedef unsigned long long ULL;
typedef pair<int, int> pii;

template <class T> inline bool Up(T &a, const T &b) { if(a < b) { a = b; return true; } return false; }
template <class T> inline bool Down(T &a, const T &b) { if(a > b) { a = b; return true; } return false; }

inline int getus() { int a, f; while(a = fgetc(stdin), !('0' <= a && a <= '9')); a -= '0'; while(f = fgetc(stdin), '0' <= f && f <= '9') a = a * 10 + f - '0'; return a; }
inline int getint() { int a, f, t; while(f = fgetc(stdin), f != '-' && !('0' <= f && f <= '9')); a = (f == '-') ? (0) : (f - '0'); while(t = fgetc(stdin), '0' <= t && t <= '9') a = a * 10 + t - '0'; return f == '-' ? -a : a; }

#define MAXN 100022

struct BIT {
	LL C[MAXN];
	int n;
	
	inline void set(int _n) {
		memset(C, 0, sizeof(C));
		n = _n;
	}
	
	inline void Add(int i, int d) {
		for( ; i <= n; i += i & -i)
			C[i] += d;
	}

	inline LL Sum(int i) {
		LL ans = 0;
		for( ; i; i -= i & -i)
			ans += C[i];
		return ans;
	}
} bit;

/*
struct Segtree {
	int n;
	int tag[MAXN << 2], weight[MAXN << 2];
	bool in[MAXN << 2];
	LL sum[MAXN << 2];
	
	void set(int _n) {
		memset(sum, 0, sizeof(sum));
		memset(tag, 0, sizeof(tag));
		memset(in, 0, sizeof(in));
		memset(weight, 0, sizeof(weight));
		n = _n;
	}
	
	void Add(int t, int nl, int nr, int cl, int cr) {
		if(nr < cl || cr < nl) return;
		if(cl <= nl && nr <= cr) {
			sum[t] += LL(nr - nl + 1) * d;
			
		}
	}
};
*/

int N, Y[MAXN], up[MAXN], down[MAXN];
int value[MAXN], totV;
int Llower[MAXN], Lupper[MAXN], Rlower[MAXN], Rupper[MAXN];
LL ans1, ans2, ans3, ans4, ans5, ans6, tot = 0;


void Div(LL a, LL b) {
	if(a == b) {
		printf("1.");
		Rep(i, 1, 20) putchar('0');
		puts("");
	}
	else if(a == 0) {
		printf("0.");
		Rep(i, 1, 20) putchar('0');
		puts("");
	}
	else if(a < b) {
		printf("0.");
		Rep(i, 1, 20) {
			a *= 10;
			putchar((a / b) + '0');
			a %= b;
		}
		puts("");
	}
//	else assert(0);
}

LL Calc() {
//	memset(up, 0, sizeof(up));
//	memset(down, 0, sizeof(down));
	LL ans = 0;
	Rep(i, 1, N) {
		up[i] = down[i] = 0;
		Foru(j, 1, i) {
			if(Y[j] > Y[i])
				ans += down[j];
			if(Y[j] >= Y[i])
				ans -= up[j];
			if(Y[j] < Y[i]) {
				++up[j];
				++down[i];
			}
		}
	}
	tot += ans;
	return ans;
}

void Work() {
	bit.set(N);
	Rep(i, 1, N) {
		Llower[i] = 
			bit.Sum( Y[i] - 1 );
		Lupper[i] = bit.Sum( totV ) - bit.Sum( Y[i] );
		bit.Add(Y[i], 1);
	}
	
	ans2 = Calc();
	
	reverse(Y + 1, Y + N + 1);
	ans4 = Calc();
	
	bit.set(N);
	Rep(i, 1, N) {
		Rlower[N + 1 - i] = bit.Sum( Y[i] - 1 );
		Rupper[N + 1 - i] = bit.Sum( totV ) - bit.Sum( Y[i] );
		bit.Add(Y[i], 1);
	}
	
	Rep(i, 1, N) Y[i] = totV + 1 - Y[i];
	ans3 = Calc();
	
	reverse(Y + 1, Y + N + 1);
	ans5 = Calc();
	
	ans1 = ans6 = 0;
	Rep(i, 1, N) {
		ans1 += Llower[i] * Rupper[i];
		ans6 += Lupper[i] * Rlower[i];
	}
	tot += ans1 + ans6;
	Div(ans1, tot);
	Div(ans2, tot);
	Div(ans3, tot);
	Div(ans4, tot);
	Div(ans5, tot);
	Div(ans6, tot);
//	fprintf(stderr, "ans = %lld, %lld, %lld, %lld, %lld, %lld\n", 
//				ans1, ans2, ans3, ans4, ans5, ans6);
//	fprintf(stderr, "tot = %lld\n", tot);

}

void Init() {
	N = getus();
	Rep(i, 1, N) value[i] = Y[i] = getus();
	sort(value + 1, value + N + 1);
	totV = unique(value + 1, value + N + 1) - value - 1;
	Rep(i, 1, N) 
		Y[i] = lower_bound(value + 1, value + totV + 1, Y[i]) - value;
}

int main() {
	freopen("shape.in", "r", stdin);
	freopen("shape.out", "w", stdout);
	
	Init();
	Work();
	
	return 0;
}
