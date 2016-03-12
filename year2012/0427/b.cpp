#include<cstdio>
#include<iostream>
#include<algorithm>
#define INF 111111111
#define maxn 11111
using namespace std;

int n;
int t[maxn],f[2][maxn/2][2];

int main()
{
	freopen("b.in","r",stdin);
	freopen("b.out","w",stdout);
	
	scanf("%d",&n);
	for (int i=1;i<=n;i++)
		scanf("%d",&t[i]);
	for (int i=0;i<=1;i++)
		for (int j=0;j<=n/2;j++)
			f[i][j][0]=f[i][j][1]=INF;
	f[1][1][1]=0;
	f[1][0][0]=0;
	for (int i=2;i<=n;i++)
		for (int j=0;j<=min(n/2,i);j++)
		{
			f[i%2][j][0]=min(f[(i-1)%2][j][1]+t[i-1],f[(i-1)%2][j][0]);
			if (j>0) f[i%2][j][1]=min(f[(i-1)%2][j-1][1],f[(i-1)%2][j-1][0]+t[i-1]);
		}
		
	printf("%d\n",min(f[n%2][n/2][0],f[n%2][n/2][1]));
	return 0;
}