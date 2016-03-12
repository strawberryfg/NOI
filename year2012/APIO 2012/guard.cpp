#include<cstdio>
const int tt=1000002;
int p[tt],pd[tt],lst[tt],nxt[tt],f[tt],nxt0[tt],nxt1[tt],pk[tt];
int main(){
	int n,m,k,a,b,c,i,pp=0;
	freopen("guard.in","r",stdin);
	freopen("guard.out","w",stdout);
	scanf("%d%d%d",&n,&k,&m);
	for (i=0;i<=n+1;i++) nxt0[i]=i-1,nxt1[i]=nxt[i]=n+1,p[i]=pd[i]=pk[i]=true,lst[i]=f[i]=0;
	for (i=0;i<m;i++){
		scanf("%d%d%d",&a,&b,&c);
		if (c){if (b<nxt1[a]) nxt1[a]=b;}else{if (b>nxt0[a]) nxt0[a]=b;}
	}
	for (i=1;i<=n;i++) if (nxt0[i]>=i){
		p[i]=false;
		if (nxt0[i]>nxt0[i+1]) nxt0[i+1]=nxt0[i];
	} else pp++;
	if (pp==k) {for (i=1;i<=n;i++) if (p[i]) printf("%d\n",i); return 0;} else pp=0;
	for (i=1;i<=n+1;i++) lst[i]=p[i]?i:lst[i-1];
	for (i=n;i;i--) {nxt[i]=p[i]?i:nxt[i+1]; if (nxt1[i-1]>nxt1[i]) nxt1[i-1]=nxt1[i];}
	for (i=n;i>=0;i--) f[i]=f[lst[nxt1[i+1]]]+1;
	for (i=0;i!=n+1;i=lst[nxt1[i+1]]) pk[i]=false;
	for (i=1;i<=n;i++) pd[nxt[i]]&=(nxt[i]!=lst[nxt1[i]]);
	for (i=1;i<=n;i++) if (p[i])
		if (!pd[i] || (!pk[i] && f[0]-f[i]-1+f[lst[i-1]]>k)) pp=true,printf("%d\n",i);
	if (!pp) printf("-1\n");
}
