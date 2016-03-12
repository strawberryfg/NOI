#include<cstdio>
#include<iostream>
#define ll long long
using namespace std;
int n,p;
ll ans;
ll f[111][111][111];
ll c(int k)
{
    ll ans=1ll;
    for (int i=1;i<=k;i++)
        ans=(ll)ans*2%p;
    return ans;         
}
int main()
{
    freopen("brick.in","r",stdin);
    freopen("brick.out","w",stdout);
    scanf("%d%d",&n,&p);
    for (int i=1;i<=n;i++)
    {
        f[i][i][1]=1;
        f[i][1][i]=c(i-1)%p;
        if (i==n) ans+=1ll+c(i-1);
        for (int j=2;j<i;j++)
            for (int k=1;k<=i-(j-1);k++)
            {
                for (int e=1;e<=i-k-(j-2);e++)
                    f[i][j][k]=(f[i][j][k]+f[i-k][j-1][e]*(ll)((1+e)*c(k-1)-1))%p;
                if (i==n) ans=(ll)(ans+f[i][j][k])%p;    
            }
    }       
    cout<<ans<<'\n';
    return 0;   
}
