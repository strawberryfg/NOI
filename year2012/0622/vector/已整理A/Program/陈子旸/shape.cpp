#include <cstdio>
#include <cstring>
#include <cstdlib>

using namespace std;

#define LL long long

int n;
int a[131072];
LL cnt123=0;
LL cnt132=0;
LL cnt213=0;
LL cnt231=0;
LL cnt312=0;
LL cnt321=0;
LL sum;

void print(LL a,LL b)
{
    if (a==b) printf("1.00000000000000000000\n");
    else
    {
        printf("0.");
        for (int i=0;i<20;i++)
        {
            a*=10;
            printf("%d",(int)(a/b));
            a%=b;
        }
        printf("\n");
    }
}

int main()
{
    freopen("shape.in","r",stdin);
    freopen("shape.out","w",stdout);
    scanf("%d",&n);
    for (int i=1;i<=n;i++) scanf("%d",a+i);
    for (int i=1;i<=n;i++)
    {
        LL sl,sr,bl,br;
        sl=sr=bl=br=0;
        for (int j=1;j<i;j++)
        {
            if (a[j]<a[i]) sl++;
            if (a[j]>a[i]) bl++;
        }
        for (int j=i+1;j<=n;j++)
        {
            if (a[j]<a[i]) sr++;
            if (a[j]>a[i]) br++;
        }
        cnt123+=sl*br;
        cnt321+=bl*sr;
    }
    for (int i=1;i<=n;i++)
    {
        LL b=0,s=0;
        for (int j=i+1;j<=n;j++)
        {
            if (a[j]<a[i]) {cnt231+=b;s++;}
            if (a[j]>a[i]) {cnt213+=s;b++;}
        }
    }
    for (int i=1;i<=n;i++)
    {
        LL b=0,s=0;
        for (int j=i-1;j>0;j--)
        {
            if (a[j]<a[i]) {cnt132+=b;s++;}
            if (a[j]>a[i]) {cnt312+=s;b++;}
        }
    }
    sum=cnt123+cnt132+cnt213+cnt231+cnt312+cnt321;
    print(cnt123,sum);
    print(cnt132,sum);
    print(cnt213,sum);
    print(cnt231,sum);
    print(cnt312,sum);
    print(cnt321,sum);
    return 0;
}
