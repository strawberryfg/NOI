#include<cstdio>
#include<algorithm>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include<iostream>
using namespace std;

const int maxn=210000;
int d[maxn],s[maxn],la[maxn][22],fa[maxn],cnt;
int n,m,begin[maxn],end[maxn],a[maxn];
int point[maxn],next[maxn],fir[maxn],E;
bool f[maxn];

struct que{
    char opt;
    int A,B;
}   Q[400000];

int getf(int x){
    int i=x;
    for(;fa[i]!=i;i=fa[i]);
    for(;fa[x]!=x;x=fa[x])fa[x]=i;
    return i;
}

int lowbit(int x){
    return x&(-x);
}

void add(int i,int a){
    while(i<=cnt){
        s[i]+=a;
        i+=lowbit(i);
    }
}

int ask(int i){
    int ret=0;
    while(i){
        ret+=s[i];
        i-=lowbit(i);
    }
    return ret;
}

int lca(int x,int y){
    if(d[x]>d[y])swap(x,y);
    for(int i=20;i>=0;i--)
        if(d[la[y][i]]>=d[x])y=la[y][i];
    if(x==y)return x;
    for(int i=20;i>=0;i--)
        if(la[y][i]!=la[x][i]){
            x=la[x][i];
            y=la[y][i];
        }
    return la[x][0];
}

void dfs(int x,int fa,int dep){
    f[x]=1;
    d[x]=dep;
    la[x][0]=fa;
    for(int i=1;i<21;i++)
        la[x][i]=la[la[x][i-1]][i-1];
    begin[x]=++cnt;
    for(int k=fir[x];k;k=next[k])
        if(!f[point[k]])dfs(point[k],x,dep+1);
    end[x]=++cnt;
}

void addedge(int u,int v){
    point[E]=v;
    next[E]=fir[u];
    fir[u]=E++;
}

int main(){
    freopen("trip.in","r",stdin);
    freopen("trip.out","w",stdout);
    scanf("%d",&n);
    for(int i=1;i<=n;i++)
        scanf("%d",&a[i]);
    scanf("%d",&m);
    for(int i=1;i<=n;i++)fa[i]=i;
    E=1;
    for(int i=1;i<=m;i++){
        char str[20];
        scanf("\n%s",str);
        Q[i].opt=str[0];
        scanf("%d%d",&Q[i].A,&Q[i].B);
        if(str[0]=='b'){
            int p=getf(Q[i].A),q=getf(Q[i].B);
            if(p!=q){
                fa[p]=q;
                addedge(Q[i].A,Q[i].B);
                addedge(Q[i].B,Q[i].A);
            }
        }
    }
    memset(f,0,sizeof f);
    cnt=0;
    for(int i=1;i<=n;i++)
        if(!f[i])dfs(i,0,1);
    for(int i=1;i<=n;i++){
        add(begin[i],a[i]);
        add(end[i],-a[i]);
    }
    for(int i=1;i<=n;i++)fa[i]=i;
    for(int i=1;i<=m;i++){
        if(Q[i].opt=='b'){
            int p=getf(Q[i].A),q=getf(Q[i].B);
            if(p!=q){
                printf("yes\n");
                fa[p]=q;
            }
            else printf("no\n");
        }
        if(Q[i].opt=='p'){
            add(begin[Q[i].A],Q[i].B-a[Q[i].A]);
            add(end[Q[i].A],a[Q[i].A]-Q[i].B);
            a[Q[i].A]=Q[i].B;
        }
        if(Q[i].opt=='e'){
            int p=getf(Q[i].A),q=getf(Q[i].B);
            if(p!=q)printf("impossible\n");
            else{
                int k=lca(Q[i].A,Q[i].B);
                printf("%d\n",ask(begin[Q[i].A])+ask(begin[Q[i].B])-ask(begin[k])*2+a[k]);
            }
        }
    }
    return 0;
}
