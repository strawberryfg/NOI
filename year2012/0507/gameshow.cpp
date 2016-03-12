#include<iostream>

using namespace std;

int n,k;
long double s,f[10000005];

double abs( double k) {
       if (k-0.0000>=1e-5) return k;
          else return 0;
}

int main()
{
    freopen("gameshow.in","r",stdin);
    freopen("gameshow.out","w",stdout);
    
    cin>>n>>k;
    for (int i=1;i<=k;i++) f[i]=1;
    s=k;
    for (int i=k+1;i<=n;i++) {
        f[i]=s/(long double)i;
        s-=f[i-k];
        s+=f[i];
    }
               
    printf("%.4lf\n",abs(double(f[n])));
        
    return 0;
}
