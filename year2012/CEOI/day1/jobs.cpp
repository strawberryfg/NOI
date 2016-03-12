#include<cstdio>
#include<iostream>
#define maxn 111111
#define maxm 1111111
using namespace std;
int fst[maxn],nxt[maxm];
int t,n,d,m,k,l,r,mid;
int tot[maxn];
bool pan(int k)
{
    int m=0,cnt=0;
    for (int i=1;i<=n-d;i++)
    {
        if (cnt+(m>0)<i) cnt=i-1,m=0;
        cnt+=(tot[i]+m)/k;
        m=(tot[i]+m)%k;
        if (cnt+(m>0)-i>d) return 0;
    }
    return 1;
}
int main()
{
    freopen("jobs.in","r",stdin);
    freopen("jobs.out","w",stdout);
    scanf("%d%d%d",&n,&d,&m);
    for (int i=1;i<=m;i++)
    {
        scanf("%d",&t);
        tot[t]++;
        nxt[i]=fst[t];
        fst[t]=i;
    }
    l=0,r=m;
    while (l<r-1)
    {
        mid=(l+r)>>1;
        if (pan(mid)) r=mid;else l=mid;   
    }
    printf("%d\n",r);
    t=1;
    while (!k) k=fst[t++];
    for (int i=1;i<=n;i++)
    {
        for (int j=1;j<=r;j++)
        {
            if (k && t-1<=i) printf("%d ",k);
            else break;
            if (nxt[k]) k=nxt[k];
            else 
            { 
                k=fst[t++];
                while (!k && t<=n) k=fst[t++];
            }
        }
        printf("0\n");
    }       
    return 0;   
}
