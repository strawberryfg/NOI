#include <algorithm>
#include <cstdio>
#define rep(i,f,t) for(int i(f);i<=(t);++i)
#define per(i,t,f) for(int i(t);i>=(f);--i)
#define Cn2(N) (ll(N)*ll((N)-1ll)>>1ll)
using namespace std;
FILE *Fin= fopen("shape.in", "r"),
	*Fout= fopen("shape.out", "w");
const int MaxN= 100010;
typedef long long ll;
inline void gi(int&x){
	static char ch;
	while((ch= fgetc(Fin), ch< '0' || ch> '9') && ch!='-');
	if(ch == '-'){
		x= 0;
		while(ch= fgetc(Fin), ch>='0'&&ch<='9')
			x= x*10 + ch-'0';
		x= -x;
	}else{
		x= ch-'0';
		while(ch= fgetc(Fin), ch>='0'&&ch<='9')
			x= x*10 + ch-'0';
	}
}
int N, a[MaxN], b[MaxN], n;
ll bit[MaxN], bitC2[MaxN], bitC[MaxN], cnt[MaxN], bitM[MaxN], Cnt[MaxN];
ll cnt123, cnt321, cnt132, cnt312, cnt213, cnt231, cnnnnt; 
int cnt1[MaxN], cnt2[MaxN];
int get_rnk(int x){
	int mid, l= 1, r= n;
	while(l < r){
		mid= l+r>>1;
		b[mid] < x ? l= mid+1 : r= mid;
	}
	return l;
}
ll query(ll*bit, int x){
	ll ret(0);
	for(;x;x-= x&-x)
		ret+= bit[x];
	return ret;
}
void add(ll*bit, int x, ll delta){
	for(;x<= n;x+= x&-x)
		bit[x]+= delta;
}
void div_it(ll a, ll b){
	fputs("0.", Fout);
	for(int i= 0;i< 20;++ i){
		fprintf(Fout, "%d", int(a*10/b));
		(a*= 10ll)%= b;
	}
	fputs("\n", Fout);
}
int main(){
	gi(N);
	rep(i, 1, N) gi(a[i]), b[i]= a[i];
if(N>200){
	sort(b+1, b+1+N);
	n= unique(b+1, b+1+N) - b - 1;
	rep(i, 1, N) a[i]= get_rnk(a[i]);
//work
	rep(i, 1, N){
		cnt1[i]= query(bit, a[i]-1);
		add(bit, a[i], 1ll);
	}
	rep(i, 1, n) bit[i]= 0;
	per(i, N, 1){
		cnt2[i]= query(bit, n) - query(bit, a[i]);
		add(bit, a[i], 1ll);
	}
//	rep(i, 1, N) printf("[%d]%d %d\n", i, i-1-cnt1[i], N-i-cnt2[i]);
	rep(i, 1, N){
		cnt123+= ll(cnt1[i]) * ll(cnt2[i]);
		cnt321+= ll(i-1-cnt1[i]) * ll(N-i-cnt2[i]);
		cnt132+= Cn2(cnt2[i]);
		cnt231+= ll(cnt1[i]) * ll(N-i-cnt2[i]);
		cnt213+= ll(i-1-cnt1[i]) * ll(cnt2[i]);
		cnt312+= Cn2(N-i-cnt2[i]);
	}
	per(i, N, 1){
		ll tmp2= query(bitC2, n) - query(bitC2, a[i]), tmp= query(bitC, n) - query(bitC, a[i]);
		cnt132-= tmp2-tmp >> 1;
		tmp2= query(bitC2, a[i]-1); tmp= query(bitC, a[i]-1);
		cnt312-= tmp2-tmp >> 1;
		add(bitC2, a[i], 2ll*cnt[a[i]] + 1ll);
		add(bitC, a[i], 1ll);
		++ cnt[a[i]];
	}
//	printf("%lld\n", cnt231);
	rep(i, 1, N){
		cnt213-= query(bitM, n) - query(bitM, a[i]);
//		printf("%d:%lld\n", i, query(bitM, n) - query(bitM, a[i]));
		cnt231-= query(bitM, a[i]-1);
//		printf("%d:%lld\n", i, query(bitM, a[i]));
		add(bitM, a[i], -cnt[a[i]]*Cnt[a[i]]);
		-- cnt[a[i]], ++ Cnt[a[i]];
		add(bitM, a[i], cnt[a[i]]*Cnt[a[i]]);
	}
//	printf("%lld\n", cnt231);
	cnt132-= cnt123;
	cnt231-= cnt132;
	cnt312-= cnt321;
	cnt213-= cnt312;
	cnnnnt+= cnt123 + cnt132 + cnt213 + cnt231 + cnt312 + cnt321;
}else{
	for(int i= 1;i<= N;++ i) for(int j= i+1;j<= N;++ j) for(int k= j+1;k<= N;++ k){
//		printf("%d %d %d", a[i], a[j], a[k]);
		if(a[i]<a[j] && a[j]<a[k])
			++ cnt123;
		if(a[i]<a[k] && a[k]<a[j])
			++ cnt132;
		if(a[j]<a[i] && a[i]<a[k])
			++ cnt213;
		if(a[k]<a[i] && a[i]<a[j])
			++ cnt231;
		if(a[j]<a[k] && a[k]<a[i])
			++ cnt312;
		if(a[k]<a[j] && a[j]<a[i])
			++ cnt321;
	}
	cnnnnt+= cnt123 + cnt132 + cnt213 + cnt231 + cnt312 + cnt321;
}
//	printf("%lld\n%lld\n%lld\n%lld\n%lld\n%lld\n", cnt123, cnt132, cnt213, cnt231, cnt312, cnt321);
//	printf("%lld\n", cnnnnt);
	div_it(cnt123, cnnnnt);
	div_it(cnt132, cnnnnt);
	div_it(cnt213, cnnnnt);
	div_it(cnt231, cnnnnt);
	div_it(cnt312, cnnnnt);
	div_it(cnt321, cnnnnt);
	return 0;
}
