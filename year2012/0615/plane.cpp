//Lib
#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<cmath>
#include<ctime>

#include<iostream>
#include<algorithm>
#include<vector>
#include<string>
#include<queue>
using namespace std;
//Macro
#define rep(i,a,b) for(int i=a,tt=b;i<=tt;++i)
#define drep(i,a,b) for(int i=a,tt=b;i>=tt;--i)
#define erep(i,e,x) for(int i=x;i;i=e[i].next)
#define irep(i,x) for(__typedef(x.begin()) i=x.begin();i!=x.end();i++)
#define read() (strtol(ipos,&ipos,10))
#define sqr(x) ((x)*(x))
#define pb push_back
#define PS system("pause");
typedef long long ll;
typedef pair<int,int> pii;
const int oo=~0U>>1;
const double inf=1e100;
const double eps=1e-6;
string name="plane",in=".in",out=".out";
//Var
struct PLANE
{
	int idx,k;
	bool operator <(const PLANE &o)const{return k<o.k;}
}p[2008];
struct E
{
	int next,node;	
}e[20008];
int n,m,tot,cnt,pos[2008],h[2008],A[2008];
bool vis[2008];
void add(int a,int b){e[++tot].next=h[a];e[tot].node=b;h[a]=tot;}
void Init()
{
	scanf("%d%d",&n,&m);int a,b;
	rep(i,1,n)scanf("%d",&p[i].k),p[i].idx=i;
	rep(i,1,m)scanf("%d%d",&a,&b),add(a,b),add(b,a);
}
bool Deal(int u)
{
	erep(i,e,h[u])
	{
		if(i&1)
		{
			int v=e[i].node;
			p[u].k=min(p[u].k,p[v].k-1);
		}
	}
}
void Solve1()
{
	rep(j,1,n)
		rep(i,1,n)
			Deal(i);
	sort(p+1,p+1+n);
	rep(i,1,n-1)printf("%d ",p[i].idx);
	printf("%d\n",p[n].idx);
}
int Count(int u)
{
	int ret=0,v;vis[u]=true;
	erep(i,e,h[u])
		if(!(i&1)&&!vis[v=e[i].node])
			ret+=Count(v);
	return ret+1;
}
void Solve2()
{
	rep(i,1,n)
	{
		memset(vis,0,sizeof vis);
		int ans=Count(i);
		cnt=ans;
		rep(j,1,n)
		{
			if(!vis[p[j].idx])
			{
				cnt++;
				if(p[j].k<=ans)ans++;
				else if(cnt>p[j].k)ans=p[j].k+1;
			}
		}
		A[i]=ans;
	}
	rep(i,1,n-1)printf("%d ",A[i]);
	printf("%d\n",A[n]);
}
void Work()
{
	Solve1();
	Solve2();
}
int main()
{
	freopen((name+in).c_str(),"r",stdin);
	freopen((name+out).c_str(),"w",stdout);
	Init();
	Work();
//	PS;
	return 0;
}
