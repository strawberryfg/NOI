#include <cstdio>  
#include <cstdlib>  
#include <cstring>  
#include <cmath>  
const int maxn=1000000;  
long long f[maxn+1],s[maxn+1],phi[maxn+1],prim[maxn+1],tot,check[maxn+1];  
long long sqt(long long x) {return x*x*x;}  
void make(long long x,long long k,long long &ai,long long &bi)  
{  
  ai=bi=0;  
  for (;x%k==0;) {  
    if (!bi) bi=(k-1);else bi*=k;  
    x/=k;  
  }  
  ai=x;  
}  
void origin()  
{  
  long long ne,i,ai,bi,j;  
  phi[1]=1,f[1]=1;  
  tot=0;  
  for (i=2;i<=maxn;i++) {  
    if (!check[i]) {  
      prim[++tot]=i;  
      phi[i]=i-1;  
      f[i]=sqt(i)*f[1]-i*phi[i];  
    }  
    for (j=1;j<=tot;j++) {  
      ne=i*prim[j];  
      if (ne>maxn) break;  
      check[ne]=1;  
      if (i%prim[j]==0) {  
        phi[ne]=phi[i]*prim[j];  
        make(ne,prim[j],ai,bi);  
        f[ne]=sqt(prim[j])*f[i]-prim[j]*f[ai]*bi;  
//        f[ne]=sqt(prim[j])*f[i]-(prim[j]-1)*ai*bi;  
        break;  
      }  
      else {  
        phi[i*prim[j]]=phi[i]*(prim[j]-1);  
        f[ne]=f[i]*f[prim[j]];  
      }  
    }  
  }  
  for (i=1;i<=maxn;i++) s[i]=s[i-1]+f[i];  
}  
int main()  
{  
  freopen("Archer.in","r",stdin);  
  freopen("Archer.out","w",stdout);  
    long long t,i,x;  
    origin();  
    scanf("%I64d\n",&t);  
    for (i=1;i<=t;i++) {  
      scanf("%I64d\n",&x);  
      printf("%I64d\n",s[x]);  
    }  
  return 0;  
}  