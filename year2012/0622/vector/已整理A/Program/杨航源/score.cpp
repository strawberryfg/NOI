#include<algorithm>
#include<iostream>
#include<cstring>
#include<cstdio>
#include<cmath>
using namespace std;
int f[110][5],x,i,j,k,n,t=0;
char ch[10],c;

int main(){
  freopen("score.in","r",stdin);
  freopen("score.out","w",stdout);
  memset(f,0,sizeof(f));
  scanf("%d",&n);gets(ch);
  while(c!='\n'){
    c=getchar();
    switch(c){
      case'y':{f[t][1]++;f[t][0]++;break;}
      case'r':{f[t][2]++;f[t][0]++;break;}
      case'g':{f[t][3]++;f[t][0]++;break;}
      case'b':{f[t][4]++;f[t][0]++;break;}
      case' ':{t=0;break;}
      default:{
        t=t*10+c-48;
        break;
      }
    }
  }
  t=0;
  for(i=1;i<=4;i++)
    for(j=1;j<=100;j++)
      if(f[j][i]!=0){
        for(k=j;f[k][i]&&k<=100;k++){}
        if(k-j>=3){t+=(100+j)*(101-j)/2;
          for(k--;k>=j;k--){
            f[k][i]--;
            f[k][0]--;
          }
          continue;
        }
      }
  for(i=1;i<=100;i++)
    if(f[i][0]>=3)t+=f[i][0];
  printf("%d\n",t);
  return 0;
}
