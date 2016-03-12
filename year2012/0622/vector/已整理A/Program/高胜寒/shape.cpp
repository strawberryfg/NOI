#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
const int tt=111111;
int ans12[tt],ans23[tt],ans32[tt],ans21[tt],cnt[tt],sa[tt],a[tt],b[tt],c[tt];
long long sb[tt];
int tot;
bool cmp(int x,int y){
	return a[x]<a[y];
}
void insa(int a){
	for (;a<=tot;a+=a&-a) sa[a]++;
}
void insb(int a,int t){
	for (;a<=tot;a+=a&-a) sb[a]+=t;
}
int qrya(int a){
	int ans=0;
	for (;a;a-=a&-a) ans+=sa[a];
	return ans;
}
long long qryb(int a){
	long long ans=0;
	for (;a;a-=a&-a) ans+=sb[a];
	return ans;
}
long long c2(int a){
	return a*(long long)(a-1)/2;
}
void pout(int a,int b){
	printf("%d.",a/b);
	a%=b;
	for (int i=0;i<20;i++){
		a*=10;
		printf("%d",a/b);
		a%=b;
	}
	puts("");
}
int main(){
	freopen("shape.in","r",stdin);
	freopen("shape.out","w",stdout);
	int i,n;
	long long res123,res132,res213,res231,res312,res321,ans;
	scanf("%d",&n);
	for (i=1;i<=n;i++){
		scanf("%d",a+i);
		c[i]=i;
	}
	sort(c+1,c+n+1,cmp);
	b[c[1]]=tot=1;
	for (i=2;i<=n;i++) b[c[i]]=(a[c[i]]==a[c[i-1]])?tot:++tot;
	res123=res132=res213=res231=res312=res321=0;
	for (i=1;i<=tot;i++) cnt[i]=sa[i]=sb[i]=0;
	for (i=1;i<=n;i++){
		insa(b[i]);
		insb(b[i],cnt[b[i]]);
		cnt[b[i]]++;
		ans12[i]=qrya(b[i]-1);
		ans32[i]=i-(ans12[i]+cnt[b[i]]);
		res213+=c2(ans12[i])-qryb(b[i]-1);
		res231+=c2(ans32[i])-(qryb(tot)-qryb(b[i]));
	}
	for (i=1;i<=tot;i++) cnt[i]=sa[i]=sb[i]=0;
	for (i=n;i;i--){
		insa(b[i]);
		insb(b[i],cnt[b[i]]);
		cnt[b[i]]++;
		ans21[i]=qrya(b[i]-1);
		ans23[i]=n-i+1-(ans21[i]+cnt[b[i]]);
		res312+=c2(ans21[i])-qryb(b[i]-1);
		res132+=c2(ans23[i])-(qryb(tot)-qryb(b[i]));
	}
	for (i=1;i<=n;i++){
		res123+=ans12[i]*(long long)ans23[i];
		res321+=ans32[i]*(long long)ans21[i];
	}
	res132-=res123,res312-=res321,res213-=res123,res231-=res321;
	ans=res123+res132+res213+res231+res312+res321;
	pout(res123,ans);pout(res132,ans);pout(res213,ans);
	pout(res231,ans);pout(res312,ans);pout(res321,ans);
	return 0;
}