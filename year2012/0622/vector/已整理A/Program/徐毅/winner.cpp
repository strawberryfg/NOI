#include <algorithm>
#include <climits>
#include <cstdio>
#include <cstring>

using namespace std;

const int MAXN = 333, MAXM = 111111;

int h[MAXN], d[MAXN], q[MAXN], w[MAXN], n, m, size;

struct edge
{
    int p, c, nxt;

    inline edge(int _p = 0, int _c = 0, int _nxt = -1) :
        p(_p), c(_c), nxt(_nxt) {}
} e[MAXM];

inline void addedge(int x, int y, int c1, int c2)
{
    e[size] = edge(y, c1, h[x]);
    h[x] = size ++;
    e[size] = edge(x, c2, h[y]);
    h[y] = size ++;
}

inline bool bfs()
{
    memset(d, -1, sizeof d);
    int r = q[0] = d[0] = 0;
    for (int l = 0; l <= r; ++ l)
        for (int k = h[q[l]]; k > -1; k = e[k].nxt)
            if (e[k].c && d[e[k].p] == -1)
            {
                d[e[k].p] = d[q[l]] + 1;
                q[++ r] = e[k].p;
            }
    return d[n + 1] > -1;
}

int dfs(int u, int exp)
{
    if (u == n + 1)
        return exp;
    for (int &k = w[u], flow; k > -1; k = e[k].nxt)
        if (e[k].c && d[e[k].p] == d[u] + 1 && (flow = dfs(e[k].p, min(e[k].c, exp))))
        {
            e[k].c -= flow;
            e[k ^ 1].c += flow;
            return flow;
        }
    return 0;
}

int main()
{
    freopen("winner.in", "r", stdin);
    freopen("winner.out", "w", stdout);
    scanf("%d%d", &n, &m);
    memset(h, -1, sizeof h);
    for (int i = 1; i <= n; ++ i)
    {
        int x;
        scanf("%d", &x);
        if (!x)
            addedge(i, n + 1, 1, 0);
        else
            addedge(0, i, 1, 0);
    }
    while (m --)
    {
        int x, y;
        scanf("%d%d", &x, &y);
        addedge(x, y, 1, 1);
    }
    int ans = 0;
    while (bfs())
    {
        memcpy(w, h, sizeof h);
        int flow;
        while (flow = dfs(0, INT_MAX))
            ans += flow;
    }
    printf("%d\n", ans);
    return 0;
}
