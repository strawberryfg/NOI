#include<iostream>
#include<cstdio>
#include<cstring>
#include<cmath>
#include<cstdlib>
using namespace std;
int n,jj,x;
int b[10001],a[10001],m[10001];


int main(){
    freopen("numfill.in","r",stdin);
    freopen("numfill.out","w",stdout);
    srand( (unsigned)time( NULL ) );
    scanf("%d",&n);
    if (n%4>2 || n%4==0){
               jj=0;
               printf("Yes\n");
               for (int z=1;z<=1000001 && jj!=1;z++){
                   memset(b,0,sizeof b);
                   a[1]=1;b[1]=1;
                   int n1=1;
                   while (n1<=n){
                         x=rand() % (n+1)+1;
                         if (!b[x]) {n1++;b[x]=1;a[n1]=x;}
                   }
                   memset(m,0,sizeof m);
                   a[0]=a[n];
                   int check=1;
                   for (int i=1;i<=n;i++){
                       int x=abs(a[i]-a[i-1]);
                       if (m[x]) check=0; else m[x]=1;
                   }
                   if (check){
                      for (int i=1;i<n;i++)
                          printf("%d ",a[i]);
                      printf("%d\n",a[n]);
                      jj=1;
                   }
               }
     }
    else printf("No\n");
}
