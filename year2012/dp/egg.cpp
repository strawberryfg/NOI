#include<iostream>
#include<cmath>
#define maxlogn 20
#define maxnum 1000000000
using namespace std;
long n,eggnum,now,old,g[maxlogn+1];
void init()
{
    long i;
    now=1;
    for (i=1; i<=eggnum; i++)
         g[i]=1;
}
void work()
{
    long i,j,p;
    for (i=2; i<=n; i++)
    {
        for (j=eggnum; j>=2; j--)
        {
            g[j]=g[j-1]+g[j]+1;
            if ((j==eggnum)&&(g[j]>=n))
               {
                  cout<<i<<endl;
                  return;
               }
        }
    g[1]=i;
    if ((eggnum==1)&&(g[1]>=n))
       {
           cout<<i<<endl;
           return;
       }
    }
}
int main()
{
    long temp;
    while (1)
    {
        cin>>eggnum;
        if (eggnum==0)
           break;
        else cin>>n;
        temp=long (floor(log(n+0.0)/log(2.0))+1.0);
        if (eggnum>=temp)
           cout<<temp<<endl;
        else {
                 init();
                 if (g[eggnum]>=n)
                     cout<<1<<endl;
                 else if (eggnum==1)
                         cout<<n<<endl;
                      else work();
             }
    }
    return 0;
}
