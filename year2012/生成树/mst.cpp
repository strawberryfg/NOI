#include<cstdio>
#include<algorithm>
using namespace std;
const int maxn=1000000;
int pre,s,t,tot,n;
struct edge{
	int nxt,pur,pd,flow;
};
edge v[400005];
int sta[20005],dis[20005],que[20005];
void build(int a,int b,int c){
	v[tot].nxt=sta[a];
	v[tot].pur=b;
	v[tot].pd=c;
	v[tot].flow=1;
	sta[a]=tot++;
	v[tot].nxt=sta[b];
	v[tot].pur=a;
	v[tot].pd=0;
	v[tot].flow=1;
	sta[b]=tot++;
}
void spfa(int now){
	int i,l,r;
	for (i=1;i<=n;i++) dis[i]=maxn;
	dis[now]=0; 
	for (que[l=r=0]=t;l<=r;l++){
		for (i=sta[que[l]];i!=-1;i=v[i].nxt){
			if (v[i^1].flow && v[i].pd==pre && dis[v[i].pur]==maxn){
				dis[v[i].pur]=dis[que[l]]+1;
				que[++r]=v[i].pur;
			}
		}
	}
}
int sap(int now,int ans){
	if (ans==0 || (!dis[now])) return ans;
	int q=maxn,p=ans,g;
	for (int i=sta[now];i!=-1;i=v[i].nxt){
		if (v[i].flow && v[i].pd==pre && dis[now]>dis[v[i].pur]){
			g=sap(v[i].pur,min(p,v[i].flow));
			p-=g; 
			v[i^1].flow+=g;
			v[i].flow-=g;
		}
	}
	q=maxn;
	for (int i=sta[now];i!=-1;i=v[i].nxt)
		if (v[i].flow && v[i].pd==pre && dis[v[i].pur]+1<q) q=dis[v[i].pur]+1;
	dis[now]=q;
	return ans-p;
}
int flown(){
	spfa(t);
	int b=0;
	while (1){
		int a=sap(s,maxn);
		if (a) b+=a; else return b;
	}
}
int main(){
	int m,i,ans,c;
	freopen("mst.in","r",stdin);
	freopen("mst.out","w",stdout);
	scanf("%d%d",&n,&m);
	tot=0;
	for (i=1;i<=n;i++) sta[i]=-1;
	for (i=0;i<m;i++){
		scanf("%d%d%d",&s,&t,&c);
		build(s,t,c);
	}
	scanf("%d%d%d",&s,&t,&c);
	for (i=0;i<m;i++){
		if (v[i*2].pd>c){
			v[i*2].pd=v[i*2+1].pd=1;
		} else
		if (v[i*2].pd<c){
			v[i*2].pd=v[i*2+1].pd=2;
		} else{
			v[i*2].pd=v[i*2+1].pd=0;
		}
	}
	pre=1;
	ans=flown();
	pre=2;
	ans+=flown();
	printf("%d\n",ans);
	return 0;
}
