#include<cstdio>
#include<cmath>
#include<algorithm>
using namespace std;
typedef long long ll;
const int tot=1000000;
struct point{
	int x,y,k;
	ll b;
};
point v[tot];
int sta[tot];
double stb[tot];
inline double sqr(double a){
	return a*a;
}
inline long long sqr(int a){
	return a*ll(a);
}
void getint(int &a){
	char c;
	do c=getchar(); while (c<'-');
	if (c=='-'){
		a=0;
		c=getchar();
		do{
			a=a*10+c-'0';
			c=getchar();
		}while (c>='0');
		a=-a;
	} else{
		a=0;
		do{
			a=a*10+c-'0';
			c=getchar();
		}while (c>='0');
	}
}
inline void cmax(double &a,double b){
	if (b>a) a=b;
}
bool cmp(point a,point b){
	return a.x<b.x || (a.x==b.x && a.y<b.y);
}
int main(){
	int n,l,i,top;
	double ans;
	freopen("mobile.in","r",stdin);
	freopen("mobile.out","w",stdout);
	getint(n);
	getint(l);
	for (i=0;i<n;i++){
		getint(v[i].x);
		getint(v[i].y);
		if (v[i].y<0) v[i].y=-v[i].y;
	}
	sort(v,v+n,cmp);
	for (i=0;i<n;i++){
		v[i].k=-2*v[i].x;
		v[i].b=sqr(v[i].x)+sqr(v[i].y);
	}
	sta[top=0]=0,stb[0]=0;
	for (i=1;i<n;i++) if (v[i].x!=v[i-1].x){
		for(;top>=0&&stb[top]*v[i].k+v[i].b<=stb[top]*v[sta[top]].k+v[sta[top]].b;top--);
		sta[++top]=i;
		stb[top]=top?((v[i].b-v[sta[top-1]].b)/double(v[sta[top-1]].k-v[i].k)):0;
	}
	ans=0;
	for (i=0;i<=top;i++){
		if (stb[i]>l) break;
		cmax(ans,sqrt(sqr(v[sta[i]].x-stb[i])+sqr(v[sta[i]].y)));
	}
	cmax(ans,sqrt(sqr(v[sta[i-1]].x-l)+sqr(v[sta[i-1]].y)));
	printf("%.6lf\n",ans);
	return 0;
}
