#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cctype>
#include <map>
#include <algorithm>
using namespace std;
typedef long long ll;
void getint(int &x){
     int c;
     while (!isdigit(c=getchar()));
     x=c-48;
     while (isdigit(c=getchar())) x=x*10+c-48;
}
map<int,int> h;
int a[100010],b[100010],l[100010],r[100010];
ll c[10],s;
int main(){
    int n,m,i,j;
    freopen("shape.in","r",stdin);
    freopen("shape.out","w",stdout);
    getint(n);
    for (i=1;i<=n;i++)
        getint(a[i]);
    memcpy(b,a,sizeof(a));
    sort(b+1,b+n+1);
    h[b[1]]=m=1;
    for (i=2;i<=n;i++)
        if (b[i]!=b[i-1]) h[b[i]]=++m;
    for (i=1;i<=n;i++)
        a[i]=h[a[i]];
    for (i=2;i<=n;i++)
        r[a[i]]++;
    for (i=2;i<=m;i++)
        r[i]+=r[i-1];
    for (i=1;i<=n;i++){
        c[0]+=l[a[i]-1]*(n-i-r[a[i]]);
        c[5]+=(i-1-l[a[i]])*r[a[i]-1];
        for (j=1;j<i;j++)
            if (a[j]<a[i]){
               c[1]+=r[a[i]-1]-r[a[j]];c[3]+=r[a[j]-1];
            }
            else
              if (a[j]>a[i]){
                 c[2]+=n-i-r[a[j]];c[4]+=r[a[j]-1]-r[a[i]];
              }
        for (j=a[i];j<=m;j++)
            l[j]++;
        for (j=a[i+1];j<=m;j++)
            r[j]--;
    }
    s=c[0]+c[1]+c[2]+c[3]+c[4]+c[5];
    for (i=0;i<6;i++){
        if (c[i]==s){
           printf("1.00000000000000000000\n");
           continue;
        }
        printf("0.");
        for (j=1;j<=20;j++){
            c[i]*=10;
            printf("%d",int(c[i]/s));
            c[i]%=s;
        }
        printf("\n");
    }
    return 0;
}
