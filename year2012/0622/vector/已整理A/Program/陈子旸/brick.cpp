#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <iostream>

using namespace std;

#define LL long long

LL M;
LL n;

struct mat
{
    LL d[5][5];
    mat(){memset(d,0,sizeof(d));}
}f,cg;

mat operator * (mat a,mat b)
{
    mat c;
    for (int i=0;i<5;i++)
        for (int j=0;j<5;j++)
            for (int k=0;k<5;k++)
                c.d[i][j]=(c.d[i][j]+a.d[i][k]*b.d[k][j])%M;
    return c;
}

mat operator ^ (mat a,int b)
{
    if (b==1) return a;
    mat t=a^(b/2);
    t=t*t;
    if (b&1) t=t*a;
    return t;
}

int main()
{
    freopen("brick.in","r",stdin);
    freopen("brick.out","w",stdout);
    cg.d[4][4]=7;
    cg.d[3][4]=-14;
    cg.d[2][4]=11;
    cg.d[1][4]=-2;
    cg.d[4][3]=cg.d[3][2]=cg.d[2][1]=cg.d[1][0]=1;
    f.d[0][0]=1;
    f.d[0][1]=1;
    f.d[0][2]=3;
    f.d[0][3]=12;
    f.d[0][4]=51;
    cin >> n >> M;
    f=f*(cg^n);
    cout << ((f.d[0][0]%M)+M)%M << endl;
    return 0;
}
