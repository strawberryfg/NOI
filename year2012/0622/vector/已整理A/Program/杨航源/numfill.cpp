#include<algorithm>
#include<iostream>
#include<cstring>
#include<cstdio>
#include<cmath>
using namespace std;
bool f[1010],f1[1010],fa=false;
int a[1010],i,j,n;

void DFS(int x,int dep){
  int y;
  if(dep==n){if(f[abs(a[n]-x)])fa=true;}
    else for(int i=2;i<=n;i++){
      if(fa)return;
      y=abs(i-x);
      a[dep]=i;
      if(f[y]&&f1[i]){
        f[y]=f1[i]=false;
        DFS(i,dep+1);
        f[y]=f1[i]=true;
      }
    }
}

int main(){
  freopen("numfill.in","r",stdin);
  freopen("numfill.out","w",stdout);
  memset(f,true,sizeof(f));
  memset(f1,true,sizeof(f1));
  scanf("%d",&n);
  a[1]=1;a[n]=n+1;
  f[n]=false;
  if(n<=13)DFS(1,2);
  if(n==15){printf("Yes\n");
    printf("1 7 8 11 6 10 12 5 13 4 14 3 15 2 16\n");
    return 0;
  }
  if(!fa)printf("NO\n");
    else{
      printf("Yes\n");
      for(i=1;i<n;i++)
        printf("%d ",a[i]);
      printf("%d\n",a[n]);
    }
  return 0;
}

