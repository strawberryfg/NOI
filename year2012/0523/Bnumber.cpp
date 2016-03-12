#include<cstdio>
#include<algorithm>
#include<cstring>
#include<iostream>
#include<cstdlib>

using namespace std;

const int maxn=110000;

static int n,m;
static int d1[10][maxn],d2[10][maxn],dt[10];
struct T{
	int x1,y1,x2,y2;
	T(int X1=0,int Y1=0,int X2=0,int Y2=0):x1(X1),y1(Y1),x2(X2),y2(Y2){}
	friend bool operator <(const  T&a,const T &b){
		if (a.y1+a.y2<b.y1+b.y2) return true;
		if (a.y1+a.y2>b.y1+b.y2) return false;
		if (a.x1<b.x1) return true;
		if (a.x1>b.x1) return false;
		if (a.y1==b.y1)
			return (a.x2<b.x2);
		if (a.y1>b.y1)
			return a.x1<b.x2;
		else return a.x2<b.x1;
	}
}ans;
void sol(int n){
	memset(d1,0,sizeof(d1));
	memset(d2,0,sizeof(d2));
	for (int i=1;i<=9;i++)
	{
		dt[i]=i;
		d1[i][i%n]=d2[i][i%n]=1;
	}
	ans.y1=10000000;ans.y2=10000000;
	for (int tl=2;tl<=2*n&&ans.y1>n;tl++){
		for (int i=1;i<=9;i++){
			dt[i]=(dt[i]*10+i)%n;
			for (int j=1;j<=i;j++){
				if (d1[j][dt[i]]!=0){
					T now=T(i,tl-d1[j][dt[i]],i-j,d1[j][dt[i]]);
					if (now<ans) ans=now;
				}
			}
			for (int j=1;j<=9-i;j++){
				if (d2[j][n-dt[i]]!=0){
					T now=T(i,tl-d2[j][n-dt[i]],i+j,d2[j][n-dt[i]]);
					if (now<ans) ans=now;
				}
			}
		}
		for (int i=1;i<=9;i++){
			if (d1[i][dt[i]]==0||d1[i][dt[i]]<tl) d1[i][dt[i]]=tl;
			if (d2[i][dt[i]]==0) d2[i][dt[i]]=tl;
		}
	}
	printf("%d %d %d %d\n",ans.y1,ans.x1,ans.y2,ans.x2);
}
int main(){
	freopen("Bnumber.in","r",stdin);
	freopen("Bnumber.out","w",stdout);
	scanf("%d",&n);
	while (n){
		sol(n);
		scanf("%d",&n);
	}
	return 0;
}

