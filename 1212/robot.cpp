// robot.cpp
// Standard Program For Shanghai Team Selection Constest 2010
// Written by Cao Qinxiang

#include <iostream>
#define maxn 2000010

int x[maxn], low[maxn], d[maxn], l[maxn], r[maxn];
int n;

int min(int a, int b)
{
    if (a<b)
        return a;
    else
        return b;
}

int main()
{
    freopen("robot.in","r",stdin);
    freopen("robot.out","w",stdout);
    scanf("%d\n",&n);
    for (int i=0;i<n;++i)
        scanf("%d %d\n",x+i,d+i);
    low[n-1]=x[n-1]-d[n-1];
    for (int i=n-2;i>=0;--i)
        low[i]=min(x[i]-d[i],low[i+1]);
    int h=0, s1=0, s2=0;
    // r[h]   栈中编号h的块爆炸后间接波及的最右侧位置
    // l[h]   栈中编号h的块要被引爆所需波及的最右侧的位置 
    for (int i=0;i<n;++i)
    {
        while (h>0)
            if (r[h]>=x[i])
                break;
            else
            {
                --h;
                if (h==0)
                    if (low[i]<=l[1])
                        ++s1;
                    else
                        ++s2;
                else
                    ++s1;
            }
        r[h+1]=x[i]+d[i];
        while (h>0)
            if (l[h]<x[i]-d[i])
                break;
            else
            {
                if (r[h]<r[h+1])
                    r[h]=r[h+1];
                --h;
            }
        ++h;
        l[h]=x[i];
    }
    ++s2;
    s1+=(h-1);
    printf("%d\n%d\n",s2,s1+s2);
    fclose(stdin);
    fclose(stdout);
}
