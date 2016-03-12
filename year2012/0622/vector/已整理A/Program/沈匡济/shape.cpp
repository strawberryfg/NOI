#include<cstdio>
#include<iostream>
using namespace std;
int n,cnt;
int a[111111],b[11];
void skjout(int a,int b)
{
    if (a==b)
    {
       printf("1.");
       for (int i=1;i<=20;i++)
           printf("0");
       printf("\n");
       return ;         
    }     
    printf("0.");
    for (int i=1;i<=20;i++)
    {
        a*=10;
        printf("%d",a/b);
        a%=b;
    }
    printf("\n");
}
int main()
{
    freopen("shape.in","r",stdin);
    freopen("shape.out","w",stdout);
    scanf("%d",&n);
    for (int i=1;i<=n;i++)
        scanf("%d",a+i);
    for (int i=1;i<=n;i++)
    {
        for (int j=1;j<i;j++)
            if (a[j]<a[i])
            {
               for (int k=i+1;k<=n;k++)
               {
                   if (a[k]==a[i] || a[k]==a[j]) continue;
                   cnt++;
                   if (a[k]>a[i]) b[1]++;
                   else if (a[k]>a[j]) b[2]++;
                   else b[4]++;
               }      
            }else
            {
               if (a[j]==a[i]) continue;
               for (int k=i+1;k<=n;k++)
               {
                   if (a[k]==a[i] || a[k]==a[j]) continue;
                   cnt++;
                   if (a[k]<a[i]) b[6]++;
                   else if (a[k]>a[j]) b[3]++;
                   else b[5]++;
               } 
            } 
    }
    for (int i=1;i<=6;i++)
        skjout(b[i],cnt);
    return 0;   
}
