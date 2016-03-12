#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <ctime>
#include <algorithm>
using namespace std;
int n,m,ans,cnt;
int a[60],b[1010];
inline int cmp(const int a,const int b){
       return a>b;
}
void sc(int dep,int now){
     if (now+m-dep+1<=ans) return;
     cnt++;
     if (cnt>15000000){
        printf("%d\n",ans);
        exit(0);
     }
     if (dep>m){
        ans=now;
        if (ans==m){
           printf("%d\n",ans);
           exit(0);
        }
     }
     else{
       for (int i=1;i<=n;i++)
           if (b[dep]<=a[i]){
              a[i]-=b[dep];
              sc(dep+1,now+1);
              a[i]+=b[dep];
           }
       sc(dep+1,now);
     }
}
int main(){
    int i;
    freopen("fence.in","r",stdin);
    freopen("fence.out","w",stdout);
    scanf("%d",&n);
    for (i=1;i<=n;i++)
        scanf("%d",&a[i]);
    sort(a+1,a+n+1,cmp);
    scanf("%d",&m);
    for (i=1;i<=m;i++)
        scanf("%d",&b[i]);
    sort(b+1,b+m+1,cmp);
    ans=cnt=0;sc(1,0);
    printf("%d\n",ans);
    return 0;
}
