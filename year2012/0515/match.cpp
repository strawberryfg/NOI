#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <algorithm>
#define INF (1<<30)
#define MM(a,t) memset(a,t,sizeof a)
#define MC(a,b) memcpy(a,b,sizeof a)
#define COUNT(t) (((t)*(t+1))/2)
#define MaxA 10000
using namespace std;
const int num[10][7]={
	{1,1,1,0,1,1,1},
	{0,0,1,0,0,1,0},
	{1,0,1,1,1,0,1},
	{1,0,1,1,0,1,1},
	{0,1,1,1,0,1,0},
	{1,1,0,1,0,1,1},
	{1,1,0,1,1,1,1},
	{1,0,1,0,0,1,0},
	{1,1,1,1,1,1,1},
	{1,1,1,1,0,1,1}
};
int dec[10][10],add[10][10],na[210],nb[210],f[2][MaxA+100];
int L,p1,p2,p3,q1,q2,q3;
char s[210];
void cmin(int &a,int b){
	if (a>b) a=b;
}
void prepare(){
	MM(dec,0);MM(add,0);
	for (int i=0;i<10;i++)
		for (int j=0;j<10;j++)
			for (int p=0;p<7;p++){
				if (num[i][p] && !num[j][p]) dec[i][j]++;
				if (num[j][p] && !num[i][p]) add[i][j]++;
			}
}
void init(){
	scanf("%d",&L);
	scanf("%s",s);for (int i=1;i<=L;i++) na[i]=s[i-1]-'0';
	scanf("%s",s);for (int i=1;i<=L;i++) nb[i]=s[i-1]-'0';
	scanf("%d%d%d%d%d%d",&p1,&q1,&p2,&q2,&p3,&q3);
}
void work(){
	for (int p=0;p<=MaxA;p++) f[0][p]=f[1][p]=INF;
	f[0][0]=0;
	int t=1;
	for (int i=1;i<=L;i++,t^=1){
		for (int N=0;N<10;N++){
			int need_dec=dec[na[i]][N]+dec[nb[i]][N],need_add=add[na[i]][N]+add[nb[i]][N];
			for (int p=need_add;p<=MaxA;p++)
				f[t][p]=min(f[t][p],f[t^1][p-need_add]+need_dec);
		}
		for (int p=0;p<=MaxA;p++) f[t^1][p]=INF;
	}
	t^=1;
	int ans=INF;
	for (int i=0;i<=MaxA;i++) if (f[t][i]!=INF){
		int p=min(i,f[t][i]);
		for (int j=0;j<=p;j++)
			cmin(ans,COUNT(j)*p3+j*q3+COUNT(i-j)*p1+(i-j)*q1+COUNT(f[t][i]-j)*p2+(f[t][i]-j)*q2);
	}
	printf("%d\n",ans);
}
int main(){
	freopen("match.in","r",stdin);
	freopen("match.out","w",stdout);
	prepare();
	init();
	work();
	return 0;
}
