#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
long long g[5][2];
long long f[200002][2],sum[200002][2];
int main(){
	int n,k,i;
	long long mo;
	freopen("binary.in","r",stdin);
	freopen("binary.out","w",stdout);
	scanf("%d%d",&n,&k);
	mo=1;
	for (i=1;i<=k;i++) mo*=10;
	f[-1][0]=sum[-1][0]=1;
	f[-2][0]=sum[-2][0]=0;
	f[0][0]=1,f[0][1]=sum[0][1]=0;
	sum[0][0]=2;
	for (i=1;i<=n;i++){
		if (2*i<n){
			f[i][0]=(2*f[i-1][0]*sum[i-2][0]+f[i-1][0]*f[i-1][0])%mo;
			f[i][1]=0;
		} else
		if (2*i==n){
			f[i][0]=(2*f[i-1][0]*sum[i-2][0])%mo;
			f[i][1]=(f[i-1][0]*f[i-1][0])%mo;
		}else{
			f[i][0]=(2*sum[n-i-2][0]*f[i-1][0])%mo;
			f[i][1]=(2*f[n-i-1][0]*f[i-1][0]+2*sum[n-i-1][0]*f[i-1][1])%mo;
		}
		sum[i][0]=(sum[i-1][0]+f[i][0])%mo,sum[i][1]=(sum[i-1][1]+f[i][1])%mo;
	}
	printf("%I64d\n",sum[n][1]);
	return 0;
}
