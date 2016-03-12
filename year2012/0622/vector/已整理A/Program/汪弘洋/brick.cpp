#include <fstream>
#include <iostream>
#define maxn 205
using namespace std;
long long n,p;
long long g[maxn][maxn],f[maxn][maxn],sum[maxn],ans=0;

void solve()
{  int i,j,k,l;
	g[0][0]=1;
	for (i=1;i<=n;i++)
	{  for (j=1;j<=i;j++)  
		for (k=0;k<=i-j;k++)
			g[i][j]=(g[i][j]+g[i-j][k])%p;
    }
	
	for (i=1;i<=n;i++)
	for (j=1;j<=n;j++)
		sum[i]=(sum[i]+g[i][j])%p;
	
	for (i=1;i<=n;i++)
	{  f[i][i]=sum[i];
		for (j=1;j<i;j++)
    	{  for (k=1;k<=i-j;k++)
	    	for (l=1;l<=j;l++)
			{  f[i][j]=(f[i][j]+(f[i-j][k]*((l+k-1)*g[j][l])%p)%p)%p;
		    }
		}
	}
	for (i=1;i<=n;i++)
	{  ans=(ans+f[n][i])%p;
	}
}

int main()
{  freopen("brick.in","r",stdin); freopen("brick.out","w",stdout);
	cin>>n>>p;
	solve();
	cout<<ans<<endl;

	fclose(stdin); fclose(stdout);
	return 0;
}