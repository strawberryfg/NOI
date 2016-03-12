#include<iostream>
#include<cstdio>
#include<cstring>
#include<cstdlib>
#define LL long long

using namespace std;

int cc[33][5][5],ans[5],tt[5],two[33];
int N,P;

int main(){
	freopen("brick.in","r",stdin);
	freopen("brick.out","w",stdout);

	two[0] = 1;
	for (int i = 1;i <= 30;++ i) two[i] = two[i - 1] * 2;	
	
	scanf("%d%d",&N,&P);
	
	memset(cc,0,sizeof(cc));
	
	cc[0][1][1] = 7;
	cc[0][2][1] = (P - 14 + 14 * P) % P;
	cc[0][3][1] = 11;
	cc[0][4][1] = (P - 2 + 2 * P) % P;
	cc[0][1][2] = 1;
	cc[0][2][3] = 1;
	cc[0][3][4] = 1;
	
	for (int cs = 1;cs <= 30;++ cs) 
		for (int i = 1;i <= 4;++ i)
			for (int j = 1;j <= 4;++ j) {
				LL tmp = 0;
				for (int k = 1;k <= 4;++ k) tmp = (tmp + (LL)(cc[cs - 1][i][k]) * (LL)(cc[cs - 1][k][j])) % (LL)(P);
				cc[cs][i][j] = (int)(tmp);
			}
	
	ans[4] = 1;
	ans[3] = 3;
	ans[2] = 12;
	ans[1] = 51;
	
	if (N <= 4) {
		printf("%d\n",ans[4 - N + 1] % P);
		return 0;
	}
	else N -= 4;
	
	for (int i = 0;i <= 30;++ i)
		if ((two[i] & N) > 0) {
			for (int j = 1;j <= 4;++ j){
				LL tmp = 0;
				for (int k = 1;k <= 4;++ k) tmp = (tmp + (LL)(ans[k]) * (LL)(cc[i][k][j])) % (LL)(P);
				tt[j] = (int)(tmp);
			}
			for (int j = 1;j <= 4;++ j) ans[j] = tt[j];
		}
	
	printf("%d\n",ans[1] % P);	

	return 0;
}
