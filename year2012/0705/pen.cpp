#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
#include <vector>
#include <queue>
using namespace std;
#define Rep(i,j,k) for(int i=(j); i<=(k); i++)
#define TR(a,e) for(typeof((a).begin()) e=(a).begin(); e!=(a).end(); e++)
#define TRd(a,e) for(typeof((a).rbegin()) e=(a).rbegin(); e!=(a).rend(); e++)
#define pb push_back
#define sz(a) ((int)(a).size())
#define maxn 1000001
typedef vector<int> VI;

VI son[maxn],a;
int fa[maxn], col[maxn], n, root, pos[maxn], tot, q[maxn], size[maxn], being_used;

int one_son(int x){
	int res=0, abr=-1;
	TR(son[x],y)
		if (col[*y]==0)
			res++, abr=*y;
	if (res>1) return 0;
	return abr;
}

queue<int> Q;
vector<int> V;
void dfs(int x){
	Q.push(x);
	V.clear();
	while(!Q.empty()){
		int x=Q.front(); Q.pop();
		V.pb(x); size[x]=1;
		TR(son[x],y)
			Q.push(*y);
	}
	TRd(V,x)
		size[fa[*x]]+=size[*x];
}

int main(){
	freopen("pen.in","r",stdin);
	freopen("pen.out","w",stdout);
	
	scanf("%d",&n); root=-1;
	Rep(i,1,n){
		scanf("%d%d",fa+i,col+i);
		if (fa[i]==i) root=i; else son[fa[i]].pb(i);
		pos[col[i]]=i;
	}
	col[root]=n;
	pos[n]=root;
	
	tot=being_used=0;
	Rep(c,1,n)
		if (pos[c]==0) q[++tot]=c; 
		else{
			int x=pos[c];
			
			size[x]=0;
			TR(son[x],y)
				if (col[*y]) 
					size[x]+=size[*y];
				else 
					dfs(*y), being_used+=size[*y];
					
			if (size[x] && one_son(x)!=-1) a.pb(x);
			
			if (being_used==tot){
				while(1){
					x=one_son(x);
					if (x<=0) break;
					if (sz(a)>1 && q[tot]<col[a[sz(a)-2]]) break;
					col[x]=q[tot--];
				}
				tot=being_used=0;
				TR(a,x) size[*x]=0;
				a.clear();								
			}
		}
		
	Rep(i,1,n)
		printf("%d\n",col[i]);
	
	return 0;
}
