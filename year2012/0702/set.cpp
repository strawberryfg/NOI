#include <cstdio>
#include <cstring>
#include <cstdlib>

using namespace std;

#define M 1000000007

int cn=0,ans=0;
int mab[256];
int bit[256];
int c[16]={};
int mask[16]={};
int pr[100];
int pn=0,n,kk;
int f[100][100][256];

void dfs(int dep,int now,int st)
{
    if (dep==8)
    {
        if (now<=23)
        {
            c[cn]=now;
            mask[cn++]=st;
        }
        return;
    }
    dfs(dep+1,now,st);
    dfs(dep+1,now*pr[dep],st|(1<<dep));
}

int main()
{
    freopen("set.in","r",stdin);
    freopen("set.out","w",stdout);
    for (int i=2;i<500;i++)
    {
        bool flag=true;
        for (int j=2;j*j<=i;j++)
            if (i % j == 0)
            {
                flag=false;
                break;
            }
        if (flag) pr[pn++]=i;
    }
    mab[0]=1;
    for (int i=0;i<8;i++) bit[1<<i]=i;
    for (int i=1;i<256;i++)
        mab[i]=mab[i^(i&(-i))]*pr[bit[i&(-i)]];
    dfs(0,1,0);
    memset(f,0,sizeof(f));
    scanf("%d%d",&n,&kk);
    f[0][0][0]=1;
    for (int i=0;i<=pn;i++)
        for (int j=0;j<=pn;j++)
            for (int k=0;k<256;k++)
                if (f[i][j][k]!=0)
                {
                    if (i==pn && j<=kk && j>0)
                        ans=(ans+f[i][j][k])%M;
                    if (i<pn && j<=pn)
                    {
                        f[i+1][j][k]=(f[i+1][j][k]+f[i][j][k])%M;
                        if (i<8)
                        {
                            for (int l=0;l<(1<<i);l++)
                                if (((l & k) == 0) && (pr[i]*mab[l]<=n))
                                    f[i+1][j+1][l|k|(1<<i)]=(f[i+1][j+1][l|k|(1<<i)]+f[i][j][k])%M;
                        }
                        else
                        {
                            for (int l=0;l<cn;l++)
                                if (((mask[l]&k)==0) && (c[l]*pr[i]<=n))
                                    f[i+1][j+1][k|mask[l]]=(f[i+1][j+1][k|mask[l]]+f[i][j][k])%M;
                        }
                    }
                }
    printf("%d\n",ans);
    return 0;
}
