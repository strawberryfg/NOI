#include<algorithm>
#include<iostream>
#include<cstring>
#include<cstdio>
#include<cmath>
using namespace std;
int head[310],a[100000][2];
int i,j,n,m,x,y,p[310],t=0;
int x1,x2,tt=0;

void ins(int x,int y){
  a[++t][0]=head[x];
  a[t][1]=y;
  head[x]=t;
}

int main(){
  freopen("winner.in","r",stdin);
  freopen("winner.out","w",stdout);
  memset(head,0,sizeof(head));
  scanf("%d%d",&n,&m);
  for(i=1;i<=n;i++)
    scanf("%d",&p[i]);
  for(i=1;i<=m;i++){
    scanf("%d%d",&x,&y);
    ins(x,y);
    ins(y,x);
  }
  for(i=1;i<=n;i++){
    x1=1;x2=0;
    for(j=head[i];j;j=a[j][0])
      if(p[a[j][1]]^p[i])x2++;
        else x1++;
    if(x1>x2)tt+=x2;
      else{
        tt+=x1;
        p[i]=1-p[i];
      }
  }
  printf("%d\n",tt);
  return 0;
}
