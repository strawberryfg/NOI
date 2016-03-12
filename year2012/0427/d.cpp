#include<iostream>
#include<cstdio>
#include<cmath>
#include<algorithm>
#include<cstring>
using namespace std;

int x[100100],y[100100],c[100100][2],num0[100100],num1[100100];
int fa[201000];
int id[100100][2];
int n,ans;

bool comp0(int i,int j){
     return c[i][0]<c[j][0];
}

bool comp1(int i,int j){
     return c[i][1]<c[j][1];
}

int getfa(int v){
    if (fa[v]==v) return v; else return fa[v]=getfa(fa[v]);
}

void merge(int x,int y){
     int p=getfa(x),q=getfa(y);
     if (p!=q) fa[q]=p;
}

bool tomergediff(int i,int j){
     //printf("diff:: %d %d\n",i,j);
     merge(id[i][0],id[j][1]);
     merge(id[i][1],id[j][0]);
     int f1=getfa(id[i][0]),f2=getfa(id[i][1]);
     if (f1==f2) return false; 
     f1=getfa(id[j][0]),f2=getfa(id[j][1]);
     if (f1==f2) return false;
     return true;
}

bool tomergesame(int i,int j){
     //printf("same:: %d %d\n",i,j);
     merge(id[i][0],id[j][0]);
     merge(id[i][1],id[j][1]);
     int f1=getfa(id[i][0]),f2=getfa(id[i][1]);
     if (f1==f2) return false; 
     f1=getfa(id[j][0]),f2=getfa(id[j][1]);
     if (f1==f2) return false;
     return true;
}

bool ok(int d) {
     int ll,rr;
     for (int i=1;i<=2*n;i++) fa[i]=i;
     
     ll=1,rr=n;
     while (c[num0[rr]][0]-c[num0[ll]][0]>d&&rr>=ll) rr--;
     rr++; 
     for (int i=rr;i<=n;i++) {
         bool p=tomergediff(num0[1],num0[i]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num0[rr]][0]-c[num0[ll]][0]>d&&rr>=ll) ll++;
     ll--; 
     for (int i=2;i<=ll;i++) {
         bool p=tomergesame(num0[1],num0[i]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num0[rr]][0]-c[num0[ll]][0]>d&&rr>=ll) rr--;
     rr++; 
     for (int i=rr;i<=n-1;i++) {
         bool p=tomergesame(num0[i],num0[n]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num0[rr]][0]-c[num0[ll]][0]>d&&rr>=ll) ll++;
     ll--; 
     for (int i=1;i<=ll;i++) {
         bool p=tomergediff(num0[i],num0[n]);
         if (p==false) return false;
     }     
     
     ll=1,rr=n;
     while (c[num1[rr]][1]-c[num1[ll]][1]>d&&rr>=ll) rr--;
     rr++; 
     for (int i=rr;i<=n;i++) {
         bool p=tomergediff(num1[1],num1[i]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num1[rr]][1]-c[num1[ll]][1]>d&&rr>=ll) ll++;
     ll--; 
     for (int i=2;i<=ll;i++) {
         bool p=tomergesame(num1[1],num1[i]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num1[rr]][1]-c[num1[ll]][1]>d&&rr>=ll) rr--;
     rr++; 
     for (int i=rr;i<=n-1;i++) {
         bool p=tomergesame(num1[i],num1[n]);
         if (p==false) return false;
     }
     
     ll=1,rr=n;
     while (c[num1[rr]][1]-c[num1[ll]][1]>d&&rr>=ll) ll++;
     ll--; 
     for (int i=1;i<=ll;i++) {
         bool p=tomergediff(num1[i],num1[n]);
         if (p==false) return false;
     }        
     
     return true;
}

int main(){
    
    freopen("d.in","r",stdin);
    freopen("d.out","w",stdout);
    
    scanf("%d",&n);
    for (int i=1;i<=n;i++) {
        scanf("%d%d",&x[i],&y[i]);
        c[i][0]=x[i]+y[i];
        c[i][1]=x[i]-y[i];
        num0[i]=i,num1[i]=i;
        //printf("%d:: %d %d   %d %d\n",i,x[i],y[i],c[i][0],c[i][1]); 
    }
    
    sort(num0+1,num0+n+1,comp0);
    
    //for (int i=1;i<=n;i++) printf("%d ",num0[i]);
    //printf("\n");
    
    sort(num1+1,num1+n+1,comp1);
    
    //for (int i=1;i<=n;i++) printf("%d ",num1[i]);
    //printf("\n");
    
    if (n==2) {
       printf("0\n");
       return 0;
    }
    
    for (int i=1;i<=n;i++) {
        id[i][0]=i,id[i][1]=i+n;
    }
    
    
    int l=1,r=400000;
    while (r-l>1) {
          int mid=(l+r)/2;
          //cout<<mid<<endl;
          if (ok(mid)) r=mid; else l=mid;
    }
    if (ok(l)) ans=l; else ans=r;
    printf("%d\n",ans); 
    
    
    //bool pd=ok(1);
    //printf("%d\n",pd);
    
    
    return 0;
}
