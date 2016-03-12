#include<cstdio>
int a[10]={1,3,12,51,220,952,4121,17837,77197,334088};
int n,p;

int main()
{
    freopen("brick.in","r",stdin);
    freopen("brick.out","w",stdout);
    scanf("%d%d",&n,&p);
    printf("%d\n",a[(n-1)%10]%p);
}
