#include <cstdio>
#include <cstring>
#include <algorithm>
#include <cstdlib>
#include <iostream>
#define calc(i,j) ((i-1)*m+j)
using namespace std;
char s1[200000],s2[200000],s3[100];
int c[400000],a[200000],b[200000];
bool vis[10010],f[110][110];
int root[20010],nxt[20010],go[20010],tot,lst[10010];
int dp[13][200000],state[13],newst[13],hsh[13],t[13],n,m,k,x,y,ans;
void cmax(int &a,int b){
	if (a<b) a=b;
}
void prepare(){
	n=0,m=0;
	int l1=strlen(s1),l2=strlen(s2);
	for (int i=0;i<l1;i++) n=n*10+(s1[i]-'0');
	for (int i=0;i<l2;i++) m=m*10+(s2[i]-'0');
	memset(f,true,sizeof f);
	for (int i=1;i<=k;i++){
		scanf("%d%d",&x,&y);
		f[x][y]=false;
	}
	for (int i=1;i<=n;i++){
		for (int j=1;j<=m;j++)
			printf("%d ",f[i][j]==1);
		printf("\n");
	}
}
void solveB(){
	int l1=strlen(s1),l2=strlen(s2),l=l1+l2;
	for (int i=0;i<l1;i++) a[i]=s1[l1-i-1]-'0';
	for (int i=0;i<l2;i++) b[i]=s2[l2-i-1]-'0';
	memset(c,0,sizeof c);
	for (int i=0;i<l1;i++)
		for (int j=0;j<l2;j++)
			c[i+j]+=a[i]*b[j];
	for (int i=0;i<l;i++){
		c[i+1]+=c[i]/10;
		c[i]%=10;
	}
	while (c[l-1]==0) l--;
	for (int i=l-1;i>=0;i--){
		if (i) c[i-1]+=(c[i]%3)*10;
		c[i]/=3;
	}
	while (c[l-1]==0) l--;
	for (int i=l-1;i>=0;i--)
		printf("%d",c[i]);
	printf("\n");
}
bool find(int a){
	for (int p=root[a];p!=0;p=nxt[p]) if (!vis[go[p]]){
		vis[go[p]]=true;
		if (lst[go[p]]==0 || find(lst[go[p]])){
			lst[go[p]]=a;
			return true;
		}
	}
	return false;
}
void add(int a,int b){
	tot++;go[tot]=b;nxt[tot]=root[a];root[a]=tot;
}
void solveA(){
	prepare();
	for (int i=1;i<=n;i++)
		for (int j=1;j<=m;j++) if (f[i][j] && (i+j)%2==0){
			if (i>1 && f[i-1][j]) add(calc(i,j),calc(i-1,j));
			if (j>1 && f[i][j-1]) add(calc(i,j),calc(i,j-1));
			if (i<n && f[i+1][j]) add(calc(i,j),calc(i+1,j));
			if (j<n && f[i][j+1]) add(calc(i,j),calc(i,j+1));
		}
	for (int i=1;i<=n;i++)
		for (int j=1;j<=m;j++) if (f[i][j] && (i+j)%2==0){
			memset(vis,0,sizeof vis);
			ans+=find(calc(i,j));
		}
	printf("%d\n",ans);
}
void dfs(int N,int j,int dep,int num){
	if (dep==m){
		int k=0;
		for (int i=0;i<m;i++) if (newst[i]>=0) k+=t[i]*newst[i];
		cmax(dp[N+1][k],dp[N][j]+num);
		return ;
	}
	if (N<n && dep>0 && hsh[dep-1]==0 && newst[dep-1]==0 && newst[dep]==0){
		hsh[dep-1]=newst[dep-1]=newst[dep]=1;
		dfs(N,j,dep+1,num+1);
		hsh[dep-1]=newst[dep-1]=newst[dep]=0;
	}
	if (dep>=2 && hsh[dep]==0 && hsh[dep-1]==0 && hsh[dep-2]==0){
		hsh[dep]=hsh[dep-1]=hsh[dep-2]=1;
		dfs(N,j,dep+1,num+1);
		hsh[dep]=hsh[dep-1]=hsh[dep-2]=0;
	}
	if (N<n-1 && f[N+2][dep+1] && newst[dep]==0 && hsh[dep]==0){
		hsh[dep]=1;newst[dep]=2;
		dfs(N,j,dep+1,num+1);
		hsh[dep]=0;newst[dep]=0;
	}
	if (N<n && dep>0 && hsh[dep-1]==0 && hsh[dep]==0){
		if (newst[dep]==0){
			newst[dep]=hsh[dep]=hsh[dep-1]=1;
			dfs(N,j,dep+1,num+1);
			newst[dep]=hsh[dep]=hsh[dep-1]=0;
		}
		if (newst[dep-1]==0){
			newst[dep-1]=hsh[dep]=hsh[dep-1]=1;
			dfs(N,j,dep+1,num+1);
			newst[dep-1]=hsh[dep]=hsh[dep-1]=0;
		}
	}
	if (N<n && dep>0 && hsh[dep]==0 && newst[dep-1]==0 && newst[dep]==0){
		hsh[dep]=newst[dep-1]=newst[dep]=1;
		dfs(N,j,dep+1,num+1);
		hsh[dep]=newst[dep-1]=newst[dep]=0;
	}
	dfs(N,j,dep+1,num);
}
void solveC(){
	prepare();
	memset(dp,-1,sizeof dp);
	t[0]=1;
	dp[1][0]=0;
	for (int i=1;i<=11;i++) t[i]=t[i-1]*3;
	for (int i=1;i<=n;i++){
		for (int j=0;j<t[m];j++) if (dp[i][j]!=-1){
			int cnt=0,tmp=j;
			memset(state,0,sizeof state);
			while (tmp){
				state[cnt++]=tmp%3;
				tmp/=3;
			}
			for (int p=0;p<m;p++){
				hsh[p]=0;newst[p]=0;
				if (state[p]){hsh[p]=1;newst[p]=state[p]-1;}
				if (!f[i][p+1]) hsh[p]=1;
				if (!f[i+1][p+1]) newst[p]=-1;
			}
			dfs(i,j,0,0);
		}
	}
	ans=0;
	for (int j=0;j<t[m];j++){
		int cnt=0,tmp=j;
		while (tmp){
			state[cnt++]=tmp%3;
			tmp/=3;
		}
		cmax(ans,dp[n+1][j]);
	}
	printf("%d\n",ans);
}
int main(){
	freopen("occupy.in","r",stdin);
	freopen("occupy.out","w",stdout);
	scanf("%s%s%d%s",s1,s2,&k,s3);
	if (s3[0]=='A') solveA();
	if (s3[0]=='B') solveB();
	if (s3[0]=='C') solveC();
	return 0;
}
