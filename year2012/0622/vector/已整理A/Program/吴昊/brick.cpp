#include <cstdio>
#include <cstring>
#include <algorithm>
#include <cstdlib>
#include <iostream>
#define LL long long
using namespace std;
struct Node{
	LL num[4][4];
}x,y,z,o;
LL n,p,tt[4],ans[4];
Node qck(Node a,LL t){
	if (t==0) return o;
	//if (t==1) return a;
	Node b,c;
	c=qck(a,t/2);
	memset(b.num,0,sizeof b.num);
	for (int i=0;i<4;i++)
		for (int j=0;j<4;j++)
			for (int x=0;x<4;x++)
				b.num[i][j]=(b.num[i][j]+c.num[i][x]*c.num[x][j])%p;
	if (t%2==0) return b;
	memset(c.num,0,sizeof c.num);
	for (int i=0;i<4;i++)
		for (int j=0;j<4;j++)
			for (int x=0;x<4;x++)
				c.num[i][j]=(c.num[i][j]+b.num[i][x]*a.num[x][j])%p;
	return c;
}
int main(){
	freopen("brick.in","r",stdin);
	freopen("brick.out","w",stdout);
	memset(o.num,0,sizeof o.num);
	o.num[0][0]=o.num[1][1]=o.num[2][2]=o.num[3][3]=1;
	y.num={{0,0,0,-2},{1,0,0,11},{0,1,0,-14},{0,0,1,7}};
	cin>>n>>p;
	tt[0]=1,tt[1]=3,tt[2]=12,tt[3]=51;
	if (n<=4){
		cout<<tt[n-1]<<endl;
		return 0;
	}
	memset(x.num,0,sizeof x.num);
	x=qck(y,n-4);
	memset(ans,0,sizeof ans);
	for (int i=0;i<4;i++)
		for (int j=0;j<4;j++)
			ans[i]=(ans[i]+tt[j]*x.num[j][i])%p;
	cout<<ans[3]<<endl;
	return 0;
}
