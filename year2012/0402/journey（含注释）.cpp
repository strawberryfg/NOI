#include<cstdio>
#include<cstring>
#include<map>
using namespace std;
map<long long,bool> m;
#define mid ((l+r)>>1)
const int ver=200005;
int n,tot,la,lb,lc;
struct edge{
	edge *nxt;
	int des;
};
edge v[ver<<1],*sta[ver];
struct segmenttree{
	int tag,res;
};
segmenttree seg[ver<<2];

void mdf(int now,int l,int r){
	if (la<=l && r<=lb){
		seg[now].tag+=lc;
		seg[now].res+=lc;
	} else{
		seg[now<<1].tag+=seg[now].tag;
		seg[now<<1].res+=seg[now].tag;
		seg[(now<<1)+1].tag+=seg[now].tag;
		seg[(now<<1)+1].res+=seg[now].tag;
		seg[now].tag=0;
		if (la<=mid) mdf(now<<1,l,mid);
		if (lb>mid) mdf((now<<1)+1,mid+1,r);
		seg[now].res=(seg[(now<<1)+1].res<seg[now<<1].res)?seg[now<<1].res:seg[(now<<1)+1].res;
	}
}

int query(int now,int l,int r){
    if (la<=l && r<=lb){
       return seg[now].res;
    } else {
           	   seg[now<<1].tag+=seg[now].tag;
               seg[now<<1].res+=seg[now].tag;
               seg[(now<<1)+1].tag+=seg[now].tag;
        	   seg[(now<<1)+1].res+=seg[now].tag;
     		   seg[now].tag=0;              
     		   if (la<=mid) return query(now<<1,l,mid);
     		      else return query((now<<1)+1,mid+1,r);
           }
}

void building(int a,int b){
	if (a>b) a^=b,b^=a,a^=b;
	if (b-a!=1 && b-a!=n-1 && !m[a*(long long)n+b]){
		m[a*(long long)n+b]=true;
		(v+(++tot))->nxt=sta[a];
		sta[a]=v+tot;
		sta[a]->des=b;
		(v+(++tot))->nxt=sta[b];
		sta[b]=v+tot;
		sta[b]->des=a;
	}
}
void cmax(int &a,int b){
	if (b>a) a=b;
}
void getint(int &a){
	char c;
	do c=getchar(); while (c<'0' || c>'9');
	a=0;
	do{
		a=a*10+c-'0';
		c=getchar();
	} while (c>='0' && c<='9');
}
int main(){
	int ans,a,b,c,i;
	freopen("journey.in","r",stdin);
	freopen("journey.out","w",stdout);
	getint(n);
	tot=1;
	for (i=1;i<=n;i++) sta[i]=v;
	for (i=2;i<n;i++){
		getint(a);getint(b);getint(c);
		building(a,b);
		building(b,c);
		building(c,a);
	}
	memset(seg,0,sizeof seg);
	lc=1;
	for (i=1;i<=n-3;i++){
		a=(v+(i<<1)+1)->des;
		b=(v+(i<<1))->des;
		if (a!=1){
			la=a+1,lb=b-1;
			printf("%d %s %d %s %d %s %d\n",a,"   ->",b,"   :",la,"-   >",lb);
			if (la<=lb) mdf(1,1,n);
		}
	}
	ans=0;
	for (i=2;i<=n;i++){
		cmax(ans,seg[1].res);
		for (int j=1;j<=n;j++)
		{
            la=j; lb=j;
            printf("%d : %d        ",j,query(1,1,n));
        }
		lc=1;
		printf("\n");
		printf("\n");
		printf("\n");
		printf("----------------------\n");
		printf("\n");
		printf("\n");
		printf("\n");
		printf("%d %s\n",i,"        :");
		printf("\n");
		for (edge *e=sta[i-1];e!=v;e=e->nxt){
			a=i-1;
			b=e->des;
			if (a>b) a^=b,b^=a,a^=b;
			if (b==i-1){
				la=a+1,lb=b-1;
				printf("%d %s %d %s %d %s %d\n",a,"   ->",b,"   :",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
			} else{
				la=1,lb=a-1;
				printf("%d %s %d %s %d %s %d\n",a,"   ->",b,"   :",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
				la=b+1,lb=n;
				printf("               %d %s %d\n",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
			}
		}
		printf("\n");
		printf("\n");
//		printf("-------------------------\n");
		printf("\n");
		lc=-1;
		for (edge *e=sta[i];e!=v;e=e->nxt){
			a=i;
			b=e->des;
			if (a>b) a^=b,b^=a,a^=b;
			if (a==i){
				la=a+1,lb=b-1;
				printf("%d %s %d %s %d %s %d\n",a,"   ->",b,"     :",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
			} else{
				la=1,lb=a-1;
				printf("%d %s %d %s %d %s %d\n",a,"   ->",b,"     :",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
				la=i+1,lb=n;
				printf("                %d %s %d\n",la,"-   >",lb);
				if (la<=lb) mdf(1,1,n);
			}
		}
	}
	cmax(ans,seg[1].res);
	printf("%d\n",ans+1);
	return 0;
}
