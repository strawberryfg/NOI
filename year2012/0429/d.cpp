#include<cstdio>
#include<cstring>
int f[5555][5555];
int main(){
	int n,m,i,a,b,c,j;
	freopen("d.in","r",stdin);
	freopen("d.out","w",stdout);
	scanf("%d%d",&n,&m);
	memset(f,0,sizeof f);
	for (i=0;i<m;i++){
		scanf("%d%d%d",&a,&b,&c);
		c++;
		if (c>f[a][b]) f[a][b]=c;
	}
	for (i=1;i<n;i++)
		for (j=1;j<=i;j++){
			if (f[i][j]>f[i+1][j]) f[i+1][j]=f[i][j]-1;
			if (f[i][j]>f[i+1][j+1]) f[i+1][j+1]=f[i][j]-1;
		}
	c=0;
	for (i=1;i<=n;i++) for (j=1;j<=i;j++) if (f[i][j]) c++;
	printf("%d\n",c);
	return 0;
}
