#include <cstdio>
#include <cstring>
#include <algorithm>
#include <iostream>
#include <queue>

using namespace std;

#define Rep(i, a, b) for(int i(a); i <= (b); ++i)

template <class T> inline bool cmax(T &a, const T &b) { if(a < b) { a = b; return true; } return false; }
template <class T> inline bool cmin(T &a, const T &b) { if(a > b) { a = b; return true; } return false; }

#define Pow2(x) (1 << (x))

#define MAXN 64
#define INF 1000000000

const int dx[] = {0, 0, -1, 1}, dy[] = {-1, 1, 0, 0};

int R,C,opt[MAXN][MAXN][16], vis[MAXN][MAXN][16];
int G[MAXN][MAXN];
int ans,Limit;

struct state {
	int x, y, s;
	state() {}
	state(int _x, int _y, int _s): x(_x), y(_y), s(_s) {}
};

int main() {
	freopen("seek.in","r",stdin);
	freopen("seek.out","w",stdout);
	
	char str[MAXN];
	R = C = 0;
	while (scanf("%s",str + 1) != EOF) {
		if(str[1] == 's') break;
		for(++R, C = 0;;) {int c = str[C + 1]; if(c == '.' || c == 'X' || c == 'B') G[R][++C] = c; else break;}
	}
	
	memset(opt,63,sizeof(opt)); memset(vis,0,sizeof(vis));
	queue<state> Q;
	
	int totB = 0;
	Rep(i,1,R) Rep(j,1,C) {
		if(G[i][j] == 'B') opt[i][j][Pow2(totB)] = 0,vis[i][j][Pow2(totB)] = 1,Q.push(state(i,j,Pow2(totB))),++totB;
		else if(G[i][j] == 'X') opt[i][j][0] = 0;
		else if(G[i][j] == '.') opt[i][j][0] = (j == 1 || j == C) ? (INF) : (1);
	}
	Limit = Pow2(totB) - 1;
	
	ans = INF;
	while(!Q.empty()) {
		state tt = Q.front(); Q.pop();
		int x = tt.x, y = tt.y, s = tt.s; vis[x][y][s] = 0;
		if(s == Limit) cmin(ans,opt[x][y][s]);
		Rep(d,0,3) {
			int nx = x + dx[d], ny = y + dy[d]; if (!(nx >= 1 && nx <= R && ny >= 1 && ny <= C)) continue;
			Rep(ns,0,Limit) if(opt[nx][ny][ns] < INF) {
				if(cmin(opt[nx][ny][ns | s],opt[x][y][s] + opt[nx][ny][ns])) if(!vis[nx][ny][ns | s]) Q.push(state(nx,ny,ns | s));
				if(cmin(opt[x][y][ns | s],opt[x][y][s] + opt[nx][ny][ns]) ) if(!vis[x][y][ns | s]) Q.push(state(x,y,ns | s));
			}
		}
	}
	
	printf("%d\n", ans);
	
	return 0;
}
