#include<cstdio>
#include<cstring>
#include<cmath>
#include<algorithm>
using namespace std;
int n,a0,p1,p2,m,h[30],r,cnt,rnd,ed,fz[100][100],fm[100][100],sum,a[200],s1,s2;
double ans;

int main()
{
    freopen("chocolate.in","r",stdin);
    freopen("chocolate.out","w",stdout);
    while (scanf("%d%d%d%d%d",&n,&a0,&p1,&p2,&m))
    {
          if (n==0) return 0;
          memset(h,0,sizeof h); r=0;
          for (int i=1; i<=2*n; i++)
          {
              if (i==1)
                  a[i]=a0;
              else
                  a[i]=(a[i-1]*p1+p2)%m;
              if (i%2==0)
              {
                  if (h[a[i]])
                  {
                      r=i; break;
                  }
                  h[a[i]]=i;
              }
          }
          if (r!=0)
          {
              s1=0; s2=0;
              for (int i=h[a[r]]+1; i<=r; i++)
                  s1+=(i%2)*a[i],s2+=(i%2==0)*a[i];
              rnd=(r-h[a[r]])/2;
              for (int i=r+1; i<=r+rnd*2; i++)
                  a[i]=(a[i-1]*p1+p2)%m;
              cnt=(n-r/2)/rnd;
              ed=n-cnt*rnd;
          }
          else
              ed=n,cnt=0;
          sum=s1*cnt;
          for (int i=1; i<=ed; i++)
              sum+=a[2*i-1];
          for (int i=1; i<=ed; i++)
          {
              fz[i][i]=2*a[2*i-1];
              fm[i][i]=sum+a[2*i]+a[2*i-1];
              for (int j=i+1; j<=ed; j++)
              {
                  fz[i][j]=fz[i][j-1]+2*a[2*j-1];
                  fm[i][j]=fm[i][j-1]+a[2*j]+a[2*j-1];
              }
          }
          ans=0;
          for (int i=1; i<=ed; i++)
              for (int j=i; j<=ed; j++)
                  ans=max(ans,double(fz[i][j])/double(fm[i][j]));
//          printf("%s %d\n","be:",h[a[r]]);              
          if (cnt)
          {
              s2+=s1; s1*=2;
              for (int j=ed; j>=ed-rnd; j--)
              for (int i=1; i<=j; i++)
                  ans=max(ans,double(fz[i][j]+s1*cnt)/double(fm[i][j]+s2*cnt));
          }
          printf("%.6lf\n",ans);
    }
}
