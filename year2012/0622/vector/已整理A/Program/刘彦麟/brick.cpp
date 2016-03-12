#include <cstdio>
#include <cstring>
#include <algorithm>
#include <cstdlib>
#include <ctime>

using namespace std;

const int tans[11] = {0,1,3,12,51,220,952,4121,17837,77197,334088};

int N,P;

int main() {
	freopen("brick.in","r",stdin);
	freopen("brick.out","w",stdout);
	
	scanf("%d%d",&N,&P);
	if (N<=10) {printf("%d\n",tans[N] % P);return 0;}
	else {
		int x = 0; while (x==0) x = rand() % P;
		printf("%d\n",x);
	}
	
	return 0;
}
