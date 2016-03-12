#include <fstream>
#include <iostream>
#include <algorithm>
#include <string.h>
#define maxn 100005
using namespace std;
struct node
{  int o,data;
};
node b[maxn];
int n,a[maxn],cnt,lowbit[maxn];
long long sum[maxn];
long long ans[10],total=0;
long long p[30];

void getdata()
{  scanf("%d",&n);
	int i;
	for (i=1;i<=n;i++)
	{  scanf("%d",&b[i].data);
		b[i].o=i;
	}
}

bool comp(const node a,const node b)
{  return a.data<b.data;
}

void init()
{  int i;
	stable_sort(b+1,b+n+1,comp);
	cnt=0;
	for (i=1;i<=n;i++)
	{  if (b[i].data!=b[i-1].data) cnt++;
        a[b[i].o]=cnt; 
    }
	for (i=0;i<=n;i++) lowbit[i]=i & (-i);
}

void insert(int i,int delta)
{  while (i<=n)
	{  sum[i]+=delta;
		i+=lowbit[i];
	}
}

long long query(int i)
{  long long ans=0;
	while (i)
	{  ans+=sum[i];
		i-=lowbit[i];
	}
	return ans;
}

void solve()
{  int i,j;  long long temp;
	for (i=1;i<=n-2;i++)
	{  //memset(ans,0,sizeof(ans));
		for (j=n-1;j>i;j--)
		{  insert(a[j+1],1);
			if (a[i]<a[j])
			{  //ans1
				temp=query(n)-query(a[j]);
				ans[1]=ans[1]+temp;
				//ans2
				temp=query(a[j]-1)-query(a[i]);
				ans[2]=ans[2]+temp;
				//ans4
				temp=query(a[i]-1);
				ans[4]=ans[4]+temp;
			}
			else 
			if (a[i]>a[j])
			{  //ans3
				temp=query(n)-query(a[i]);
			    ans[3]=ans[3]+temp;
				//ans5
				temp=query(a[i]-1)-query(a[j]);
				ans[5]=ans[5]+temp;
			    //ans6
				temp=query(a[j]-1);
			    ans[6]=ans[6]+temp;
			}
        }
		memset(sum,0,sizeof(sum));
    }
}

void divide(long long a,long long b)
{  int i;
	for (i=1;i<=21;i++)
	{  if (b>a) 
		{  a=a*10; p[i]=0;
		}
	    else 
		{  p[i]=a/b;
			a=a%b; a=a*10;
		}
	}
}


void print()
{  int i,j; 
	for (i=1;i<=6;i++) total=total+ans[i];
	for (i=1;i<=6;i++)
	{  divide(ans[i],total);
		cout<<p[1]<<".";
		for (j=2;j<=21;j++) cout<<p[j];
		cout<<endl;
	}
}


int main()
{  freopen("shape.in","r",stdin); freopen("shape.out","w",stdout);
	getdata();
    init();
    solve();	
	print();
	
	fclose(stdin); fclose(stdout);
	return 0;
}