#include<cstdio>
#include<iostream>
#define maxn 1111111
using namespace std;

int n,tag;
int Max[222],Min[222],cnt[222],fst[222];
char s[maxn];
bool h[33],p[222];

void cmax(int &a,int b)
{
     if (b>a) a=b;     
}

void cmin(int &a,int b,bool &p)
{
     if (b<a) {a=b;p=1;}
     else p=0;     
}

int main()
{
    freopen("difference.in","r",stdin);
    freopen("difference.out","w",stdout);
    
    scanf("%d",&n);
    getchar();
    for (int i=1;i<=n;i++)
    {
        s[i]=getchar();
        if (fst[s[i]]==0) fst[s[i]]=i;
        h[s[i]]=1;
    }
    for (int i='a';i<='z';i++)
        if (h[i])
        {
           tag=0;
           for (int j='a';j<='z';j++)
               Min[j]=cnt[j]=Min[j]=p[j]=0;
           for (int k=1;k<=n;k++)
           {
               if (s[k]==i)
               {
                  tag++;
               }else
               {
                   if (k>fst[s[k]])
                   {
                      if (p[s[k]])
                         cmax(Max[s[k]],tag-cnt[s[k]]-Min[s[k]]-1);
                      else
                          cmax(Max[s[k]],tag-cnt[s[k]]-Min[s[k]]);
                   }
                   cnt[s[k]]++;
                   cmin(Min[s[k]],tag-cnt[s[k]],p[s[k]]);
               }  
           }
           for (int j='a';j<='z';j++)
             if (h[j] && j!=i)
               if (p[j])
                  cmax(Max[j],tag-cnt[j]-Min[j]-1);
               else
                  cmax(Max[j],tag-cnt[j]-Min[j]);
        }  
          
    for (int i='a';i<='z';i++)
        cmax(Max[0],Max[i]);
    printf("%d\n",Max[0]);
    return 0;   
}
