#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;
int n,a[101111],num,numa,sum1[2][101111],c[101111],d[101111],y;
long long ans[10],tot;
int f[4]={0,1,1,0};

struct node
{
	int x,y;
}
b[101111];

struct tree
{
	int l,r,ls,rs,cnt[2];
	long long tag[4],sum[4];
}
T[202222];

bool cmp(node a,node b)
{
	return a.x<b.x;
}

inline void add(int x,int y,int z)
{
	for (int i=y; i<=numa; i+=(i&(-i)))
		sum1[x][i]+=z;
}

inline int qry(int x,int y)
{
	int res=0;
	for (int i=y; i>0; i-=(i&(-i)))
		res+=sum1[x][i];
	return res;
}

void build(int p,int l,int r)
{
	T[p].l=l; T[p].r=r;
	if (l==r) 
	{
		T[p].cnt[1]=c[l];
		return;
	}
	int mid=(l+r)/2;
	build(T[p].ls=++num,l,mid);
	build(T[p].rs=++num,mid+1,r);
	T[p].cnt[1]=T[T[p].ls].cnt[1]+T[T[p].rs].cnt[1];
}

inline void modify(int p,int x,int l,int r,long long w)
{
	if (l>r)
		return;
	if (l<=T[p].l && T[p].r<=r)
	{
		T[p].tag[x]+=w;
		if (y==0)
		    T[p].sum[x]+=(long long)T[p].cnt[f[x]]*w;
		else
		{
			T[p].sum[x]+=w;
			if (y==2 || y==-2) y=0;
		    T[p].cnt[f[x]]+=y;
		}
		return;
	}
	if (T[p].tag[x]!=0)
	{
		//modify(T[p].ls,x,T[p].l,T[p].r,T[p].tag[x],0);
		T[T[p].ls].tag[x]+=T[p].tag[x];
		T[T[p].ls].sum[x]+=(long long)T[T[p].ls].cnt[f[x]]*T[p].tag[x];
		//modify(T[p].rs,x,T[p].l,T[p].r,T[p].tag[x],0);
		T[T[p].rs].tag[x]+=T[p].tag[x];
		T[T[p].rs].sum[x]+=(long long)T[T[p].rs].cnt[f[x]]*T[p].tag[x];
		T[p].tag[x]=0;
	}
	if (l<=T[T[p].ls].r)
		modify(T[p].ls,x,l,r,w);
	if (T[T[p].rs].l<=r)
		modify(T[p].rs,x,l,r,w);
	T[p].sum[x]=T[T[p].ls].sum[x]+T[T[p].rs].sum[x];
	T[p].cnt[f[x]]=T[T[p].ls].cnt[f[x]]+T[T[p].rs].cnt[f[x]];
}

inline long long query(int p,int x,int r)
{
	if (r==0)
		return 0;
	if (r>=T[p].r)
		return T[p].sum[x];
	if (T[p].tag[x]!=0)
	{
		//modify(T[p].ls,x,T[p].l,T[p].r,T[p].tag[x],0);
		T[T[p].ls].tag[x]+=T[p].tag[x];
		T[T[p].ls].sum[x]+=(long long)T[T[p].ls].cnt[f[x]]*T[p].tag[x];
		//modify(T[p].rs,x,T[p].l,T[p].r,T[p].tag[x],0);
		T[T[p].rs].tag[x]+=T[p].tag[x];
		T[T[p].rs].sum[x]+=(long long)T[T[p].rs].cnt[f[x]]*T[p].tag[x];
		T[p].tag[x]=0;
	}
	if (r<=T[T[p].ls].r)
		return query(T[p].ls,x,r);
	return T[T[p].ls].sum[x]+query(T[p].rs,x,r);
}

void calc(long long a,long long b)
{
     printf("0.");
     long long x;
     for (int i=1; i<=20; i++)
     {
         a=a*10ll;
         x=a/b;
         //cout<<x;
         printf("%I64d",x);
         a-=x*b;
     }
     printf("\n");
}

int main()
{
	freopen("shape.in","r",stdin);
	freopen("shape.out","w",stdout);
	scanf("%d",&n);
	for (int i=1; i<=n; i++)
	{
		scanf("%d",&a[i]);
	    b[i].x=a[i];
		b[i].y=i;
	}
	sort(b+1,b+n+1,cmp);
	b[0].x=-111;
	for (int i=1; i<=n; i++)
	{
		if (b[i].x!=b[i-1].x)
			numa++;
		a[b[i].y]=numa;
	}
	for (int i=2; i<=n; i++)
	{
		add(1,a[i],1);
		c[a[i]]++;
	}
    build(num=1,1,numa);
    int x1,y1,x2,y2;
	for (int i=1; i<n; i++)
	{
        x1=qry(0,a[i]-1);
        x2=x1+d[a[i]];
        y2=qry(1,a[i]-1);
        y1=y2+c[a[i]];
		ans[0]+=(long long)x1/*qry(0,a[i]-1)*/*(long long)(n-i-y1/*qry(1,a[i])*/);
		ans[5]+=(long long)(i-1-x2/*qry(0,a[i])*/)*(long long)y2/*qry(1,a[i]-1)*/;
		ans[1]+=query(1,1,a[i]-1);
		ans[2]+=T[1].sum[0]-query(1,0,a[i]);
		ans[3]+=query(1,3,a[i]-1);
		ans[4]+=T[1].sum[2]-query(1,2,a[i]);
		y=0; modify(1,0,1,a[i+1]-1,-1);
		y=-2; modify(1,1,a[i+1],a[i+1],-(long long)qry(0,a[i+1]-1));
		y=-1; modify(1,2,a[i+1],a[i+1],-(long long)(i-1-qry(0,a[i+1])));
		y=0; modify(1,3,a[i+1]+1,numa,-1);
		add(0,a[i],1); d[a[i]]++;
		add(1,a[i+1],-1); c[a[i+1]]--;
		y=2; modify(1,0,a[i],a[i],(long long)(n-i-1-qry(1,a[i])));
		y=0; modify(1,1,a[i]+1,numa,1);
		y=0; modify(1,2,1,a[i]-1,1);
		y=1; modify(1,3,a[i],a[i],(long long)qry(1,a[i]-1));
	}
	tot=ans[0]+ans[1]+ans[2]+ans[3]+ans[4]+ans[5];
	for (int i=0; i<=5; i++)
	{
		if (ans[i]==tot)
		{
			printf("1.00000000000000000000\n");
			continue;
		}
		/*long double res=(long double)ans[i]/(long double)tot;
		printf("0.");
		for (int j=1; j<=20; j++)
		{
			printf("%d",int(res*10));
		    res=res*10.0-(long double)(int(res*10.0));
		}
		printf("\n");*/
		calc(ans[i],tot);
	}
	return 0;
}
