#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <algorithm>
#define MaxN 5100
using namespace std;
int n,a[MaxN],num123,num132,num213,num231,num312,num321;
int main(){
	freopen("shape.in","r",stdin);
	freopen("shape.out","w",stdout);
	scanf("%d",&n);
	for (int i=1;i<=n;i++)
		scanf("%d",&a[i]);
	for (int i=1;i<=n;i++)
		for (int j=i+1;j<=n;j++)
			for (int k=j+1;k<=n;k++){
				if (a[i]<a[j] && a[j]<a[k]) num123++;
				if (a[i]>a[j] && a[j]>a[k]) num321++;
				if (a[k]<a[j] && a[i]<a[k]) num132++;
				if (a[i]<a[j] && a[k]<a[i]) num231++;
				if (a[j]<a[k] && a[k]<a[i]) num312++;
				if (a[j]<a[i] && a[i]<a[k]) num213++;
			}
	int sum=num123+num132+num213+num231+num312+num321;
	printf("%.20lf\n",double(num123)/sum);
	printf("%.20lf\n",double(num132)/sum);
	printf("%.20lf\n",double(num213)/sum);
	printf("%.20lf\n",double(num231)/sum);
	printf("%.20lf\n",double(num312)/sum);
	printf("%.20lf\n",double(num321)/sum);
	return 0;
}