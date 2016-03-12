#include <cstdio>
#include <cstring>

const int bg[6] = {0, 0, 1, 2, 3, 0}, ed[6] = {6, 6, 2, 3, 5, 6};

bool a[101][4], f[101][4][6];
int g[101][6][6][6][6], c[6];

inline void checkmax(int &x, int y)
{
    if (y > x)
        x = y;
}

int main()
{
    freopen("score.in", "r", stdin);
    freopen("score.out", "w", stdout);
    int n, ans = 0;
    scanf("%d", &n);
    while (n --)
    {
        int x;
        char y;
        scanf("%d%c", &x, &y);
        a[x][y == 'y' ? 0 : y == 'r' ? 1 : y == 'g' ? 2 : 3] = true;
    }
    memset(f, false, sizeof f);
    memset(f[0], true, sizeof f[0]);
    for (int i = 1; i < 101; ++ i)
    {
        for (int j = 0; j < 4; ++ j)
        {
            f[i][j][0] = true;
            if (a[i][j])
            {
                f[i][j][1] = f[i][j][5] = true;
                if (i > 1 && a[i - 1][j])
                {
                    f[i][j][2] = f[i - 1][j][1];
                    if (i > 2 && a[i - 2][j])
                    {
                        f[i][j][3] = f[i - 1][j][2];
                        if (i > 3 && a[i - 3][j])
                            f[i][j][4] = f[i - 1][j][3];
                    }
                }
            }
        }
        for (int x0 = 0; x0 < 6; ++ x0) if (f[i][0][x0])
            for (int x1 = 0; x1 < 6; ++ x1) if (f[i][1][x1])
                for (int x2 = 0; x2 < 6; ++ x2) if (f[i][2][x2])
                    for (int x3 = 0; x3 < 6; ++ x3) if (f[i][3][x3])
                    {
                        for (int y0 = bg[x0]; y0 < ed[x0]; ++ y0)
                            for (int y1 = bg[x1]; y1 < ed[x1]; ++ y1)
                                for (int y2 = bg[x2]; y2 < ed[x2]; ++ y2)
                                    for (int y3 = bg[x3]; y3 < ed[x3]; ++ y3)
                                        checkmax(g[i][x0][x1][x2][x3], g[i - 1][y0][y1][y2][y3]);
                        memset(c, 0, sizeof c);
                        ++ c[x0];
                        ++ c[x1];
                        ++ c[x2];
                        ++ c[x3];
                        if (c[5] > 2)
                            g[i][x0][x1][x2][x3] += c[5] * i;
                        g[i][x0][x1][x2][x3] += c[3] * (i * 3 - 3) + c[4] * i;
                        checkmax(ans, g[i][x0][x1][x2][x3]);
                    }
    }
    printf("%d\n", ans);
    return 0;
}
