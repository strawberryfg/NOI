#include<cstdio>
#include<iostream>
#define maxn 5111
using namespace std;

int n,k,root,t;
int fst[maxn],nxt[maxn],cst[maxn],lim[maxn],inf[maxn],baba[maxn],p[maxn][maxn*2];
bool hash[maxn],q[maxn][maxn*2],h[maxn];
struct edge
{
    int u,v;       
}a[maxn];

int f(int n,int k)
{
    if (k>10000) k=10000;
    if (!hash[n]) return 0;
    if (q[n][k]) return p[n][k];
    q[n][k]=1;
    if (k>lim[n] || h[n])
    {
       if (k<=lim[n]) p[n][k]=cst[n];
       for (int i=fst[n];i!=0;i=nxt[i])
           p[n][k]+=f(a[i].v,k+inf[n]);
       return p[n][k];
    }
    int ans1=cst[n],ans2=0;
    for (int i=fst[n];i!=0;i=nxt[i])
        ans1+=f(a[i].v,k+inf[n]);
    for (int i=fst[n];i!=0;i=nxt[i])
        ans2+=f(a[i].v,0);
    if (ans1<ans2) p[n][k]=ans1;
    else p[n][k]=ans2;
    return p[n][k];    
}

int main()
{
//    freopen("bribe.in","r",stdin);
//    freopen("bribe.out","w",stdout);
    
    scanf("%d%d",&n,&k);
    for (int i=1;i<=n;i++)
        scanf("%d%d%d",cst+i,inf+i,lim+i);
    for (int i=1;i<n;i++)
    {
        scanf("%d%d",&a[i].u,&a[i].v);
        nxt[i]=fst[a[i].u];
        fst[a[i].u]=i;   
        baba[a[i].v]=a[i].u; 
    }
    root=1;
    while (baba[root]!=0) 
          root=baba[root];
    hash[0]=1;
    for (int i=1;i<=k;i++)
    {
        scanf("%d",&t);
        for (int pos=t;hash[pos]!=1;pos=baba[pos])
            hash[pos]=1;
        h[t]=1;    
    }
    
    printf("%d\n",f(root,0));
    return 0;   
}
