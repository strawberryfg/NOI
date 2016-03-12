#include<iostream>
#include<cstdio>
#include<cstring>
#include<cmath>
#include<algorithm>
using namespace std;

const int P=1000000007;
const int T=26;
const int N=5*T+1;

struct matrix {
       int r,c;
       long long num[200][200];
       matrix() { memset(num,0,sizeof(num));}
} p,q,ans;

int dist[30][30];
int id[30][10];
int n,m;


void build(){
     int tt=0;
     
     memset(p.num,0,sizeof(p.num));
     memset(q.num,0,sizeof(q.num));
     
     for (int i=0;i<T;i++)
         for (int j=4;j>=0;j--) {
             id[i][j]=++tt;
             if (j==0) q.num[tt][1]=1;
             //if (j==5) q.num[tt][1]=1;
         }
     q.num[N][1]=T;
     q.r=N,q.c=1;
     
     
     for (int i=0;i<T;i++)
         for (int j=4;j>=0;j--){
             tt++;
             if (j>0) {
                p.num[id[i][j]][id[i][j]+1]=1; 
             }
             if (j==0) {
                for (int k=0;k<T;k++) {
                    p.num[id[i][j]][id[k][dist[i][k]-1]]=1;
                    p.num[N][id[k][dist[i][k]-1]]++;
                }
             }
             /*
             if (j==5) {
                for (int k=0;k<T;k++)
                    p.num[id[i][j]][id[k][dist[i][k]-1]]=1;
                p.num[id[i][j]][id[i][j]]=1;
             }
             */
         }
     
     p.num[N][N]=1;
     
     p.r=N,p.c=N;
}

inline matrix cheng(matrix a,matrix b){
       matrix c;
       c.r=a.r,c.c=b.c;
       /*for (int i=1;i<=c.r;i++)
           for (int j=1;j<=c.c;j++)
               c.num[i][j]=0;*/
       for (int i=1;i<=c.r;i++)
           for (int j=1;j<=c.c;j++)
               for (int k=1;k<=a.c;k++) {
                   c.num[i][j]+=a.num[i][k]*b.num[k][j];
                   c.num[i][j]%=P;
               }
       return c;
}

matrix pow(matrix p,int k){
       matrix q=p;
       k--;
       for (int i=0;i<=30;i++) {
           if ((1<<i)&k) q=cheng(q,p);
           //cout<<clock()<<endl;
           p=cheng(p,p);
           //cout<<clock()<<endl;
           //cout<<endl;
       }
       return q;
}

void shuchu(matrix a){
     for (int i=1;i<=a.r;i++) {
         for (int j=1;j<=a.c;j++) cout<<a.num[i][j]<<" ";
         cout<<endl;
     }
     cout<<endl;
}


int main(){
    
    freopen("reading.in","r",stdin);
    freopen("reading.out","w",stdout);
    
    for (int i=0;i<T;i++)
        for (int j=0;j<T;j++)
            dist[i][j]=1;
    
    cin>>n>>m;
    for (int i=1;i<=m;i++) {
        char c1,c2;
        int temp;
        cin>>c1>>c2>>temp;
        dist[c1-'a'][c2-'a']=dist[c2-'a'][c1-'a']=temp;
    }
    //cout<<clock()<<endl;
    
    build();
    //cout<<clock()<<endl;
    //cout<<"p::\n";
    //shuchu(p);
    //cout<<"q::\n";
    //shuchu(q);
    
    p=pow(p,n);
    //cout<<clock()<<endl;
    ans=cheng(p,q);
    //cout<<clock()<<endl;
    
    /*
    long long ret;
    for (int i=0;i<T;i++) {
        ret+=ans.num[id[i][5]][1];
        ret%=P;
    }
    if (ret<0) ret+=P;
    */
    long long ret=ans.num[N][1];
    cout<<ret<<endl;
    
    //cout<<clock()<<endl;
        
    
    
    return 0;
}
