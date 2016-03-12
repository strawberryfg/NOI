#include<iostream>
#include<cstdio>
#include<cstring>
#include<cstdlib>
#include<cmath>
using namespace std;
int n,a0,a1;
int a[100001];

int main(){
    freopen("winner.in","r",stdin);
    freopen("winner.out","w",stdout);
    scanf("%d",&n);
    for (int i=1;i<=n;i++){
        scanf("%d",&a[i]);
        if (a[i]==0) a0++;
        if (a[i]==1) a1++;
    }
    printf("%d\n",min(a0,a1));
}
