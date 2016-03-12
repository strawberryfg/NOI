#include<cstdio>
int n,m,a[111],f[111111],ans,x,y;

int main()
{
    freopen("coin.in","r",stdin);
    freopen("coin.out","w",stdout);
    scanf("%d",&n);
    m=0;
    for (int i=1; i<=n; i++)
    {
        scanf("%d",&a[i]);
        f[1]+=a[i];
        if (a[i]>m) m=a[i];
    }
    for (int i=1; i<=m/2; i++)
    {
        y=0;
        for (int j=2*i; j<=m; j+=i)
        {
            x=f[i]; y++;
            for (int k=1; k<=n; k++)
                x-=(a[k]/j)*y;
            if (x<f[j]||f[j]==0)
                f[j]=x;
        }
    }
    ans=2147483647;
    for (int i=1; i<=m; i++)
        if (f[i]<ans) ans=f[i];
    printf("%d\n",ans);
    return 0;
}
