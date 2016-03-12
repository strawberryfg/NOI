#include<iostream>
#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<algorithm>

using namespace std;

struct lx{
	int lst[300001];
} d[4];

int n[4];
int _,__,___;
int T,A,B,C,D,E,F,M,l1,r1,l2,r2;

int Djj;

bool cmp(int a1,int a2) {
	return (a1 > a2);
}

int erfen1(int x) {
	int ll = 1,rr = n[1],mid,bst = 1;
	while (ll <= rr) {
		mid = (ll + rr) / 2;
		if (d[1].lst[mid] > x) {
			bst = max(bst,mid);
			ll = mid + 1;
		}
		else rr = mid - 1;
	}
	return bst;
}

int erfen2(int x) {
	int ll = 1,rr = n[3],mid,bst = n[3];
	while (ll <= rr) {
		mid = (ll + rr) / 2;
		if (d[3].lst[mid] < x) {
			bst = min(bst,mid);
			rr = mid - 1;
		}
		else ll = mid + 1;
	}
	return bst;
}

inline void tryit(int td,int te,int tf) {
	if ((l1 <= td) && (td <= r1) && (l2 <= tf) && (tf <= r2) && ((abs(A - td) + abs(B - te) + abs(C - tf)) < Djj)) {
		Djj = abs(A - td) + abs(B - te) + abs(C - tf);
		D = td;
		E = te;
		F = tf;
	}
}

int main(){
	freopen("school.in","r",stdin);
	freopen("school.out","w",stdout);
	
	scanf("%d",&T);
	while (T --) {
		scanf("%d%d%d",&A,&B,&C);
		M = A + B + C;
		n[3] = n[1] = n[2] = 0;
		scanf("%d",&_);
		for (int i = 1;i <= _;++ i) {
			scanf("%d%d",&__,&___);
			n[__ - 1993] ++;
			d[__ - 1993].lst[n[__ - 1993]] = ___;
		}
		if ((n[3] == 0) || (n[1] == 0) || (n[2] == 0) || (M > _)) {
			printf("-1\n");
			continue;
		}
		for (int i = 1;i <= 3;++ i) sort(d[i].lst + 1,d[i].lst + n[i] + 1,cmp);
		Djj = 2147483647;
		D = E = F = -1;
		for (int i = 1;i <= n[2];++ i) {
			if ((d[1].lst[1] <= d[2].lst[i]) || (d[3].lst[n[3]] >= d[2].lst[i])) continue;
			l1 = 1;
			r1 = erfen1(d[2].lst[i]);
			l2 = erfen2(d[2].lst[i]);
			r2 = n[3];
			if (((l1 + l2 + i) > M) || ((r1 + r2 + i) < M)) continue;
			tryit(A,i,M - i - A);
			tryit(M - i - C,i,C);
			tryit(l1,i,M - i - l1);
			tryit(r1,i,M - i - r1);
			tryit(M - i - l2,i,l2);
			tryit(M - i - r2,i,r2);
		}
		if (D < 0) printf("-1\n");
		else printf("%d %d %d %d\n",Djj,D,E,F);
	}

	return 0;
}
