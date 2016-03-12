#include<cstdio>
#include<cstring>
int t[1111],f[1111][1111],g[1111];
int main(){
	int n,p,i,j,k,ans=0;
	freopen("brick.in","r",stdin);
	freopen("brick.out","w",stdout);
	scanf("%d%d",&n,&p);
	t[0]=1;
	for (i=1;i<=n;i++) t[i]=t[i-1]*2%p;
	memset(f,0,sizeof f);
	f[1][1]=1;
	for (i=2;i<=n;i++){
		f[i][i]=t[i-1];
		for (j=1;j<i;j++)
			for (k=1;k<=i-j;k++)
				f[i][j]=(f[i][j]+f[i-j][k]*(long long)((k+1)*(long long)t[j-1]%p-1))%p;
	}
	for (i=1;i<=n;i++) ans=(ans+f[n][i])%p;
	printf("%d\n",ans);
	return 0;
}