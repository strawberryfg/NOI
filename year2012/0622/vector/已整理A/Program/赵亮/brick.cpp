#include <cstdio>
#include <cstdlib>
typedef long long ll;
ll pow2[3010],t[3010],f[3010][3010],h[3010][3010],g[3010][3010];
int main(){
    int n,p,i,j,k;
    ll ans;
    freopen("brick.in","r",stdin);
    freopen("brick.out","w",stdout);
    scanf("%d%d",&n,&p);
    pow2[0]=1LL;
    for (i=1;i<=n;i++){
        pow2[i]=(pow2[i-1]<<1)%p;
        t[i]=pow2[i]?pow2[i]-1LL:p-1;
    }
    f[0][0]=1LL;
    for (i=1;i<=n;i++){
        h[i][0]=g[i][0]=0LL;
        for (j=1;j<i;j++){
            f[i][j]=(h[i-j][i-j]*t[j]+g[i-j][i-j]*pow2[j-1])%p;
            h[i][j]=(h[i][j-1]+f[i][j])%p;
            g[i][j]=(g[i][j-1]+f[i][j]*(j-1))%p;
        }
        h[i][i]=(h[i][i-1]+(f[i][i]=pow2[i-1]))%p;
        g[i][i]=(g[i][i-1]+f[i][i]*(i-1))%p;
    }
    ans=0LL;
    for (i=1;i<=n;i++)
        ans+=f[n][i];
    printf("%d\n",int(ans%p));
    return 0;
}
