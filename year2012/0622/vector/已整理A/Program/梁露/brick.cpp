#include<iostream>
#include<vector>
#include<algorithm>
#include<cstring>
#include<cstdlib>
#include<cstdio>
#include<cmath>
#define rep(i,n) for(int i=0;i<n;i++)
#define sqr(x) ((x)*(x))
using namespace std;
const int maxn=101;
const int mod=1000;
int P;

int N;
long long F[maxn];


long long jia(long long x,long long y) 
{
	return (x+y)%P;
}

long long cheng(long long x,int y) 
{
	return (x*y)%P;
}


int main()
{
	freopen("brick.in","r",stdin);
	freopen("brick.out","w",stdout);
	cin>>N>>P; 
	F[1]=1,F[2]=3,F[3]=12;F[4]=51;
	for (int i=5;i<=N;i++) 
		{ 	F[i]=jia(F[i],cheng(F[i-1],7));
			F[i]=jia(F[i],cheng(F[i-2],-14));
			F[i]=jia(F[i],cheng(F[i-3],11));
			F[i]=jia(F[i],cheng(F[i-4],-2));
		}
	// 51,220,952,4121,17837,77197,334088
	cout<<F[N]<<endl;
	return 0;
}
