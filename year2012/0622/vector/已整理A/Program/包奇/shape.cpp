#include<iostream>
#include<cstdio>
#include<cstring>
#include<map>
#include<algorithm>
#include<iterator>
#include<cstdlib>
#define LL long long

using namespace std;

map < int , int > M;

int sum[5005][5005];
int a[5005],N,bh;
LL S_123,S_132,S_213,S_231,S_312,S_321,ToT;

void High_digit_output(LL _A,LL _B){
	LL A = _A,B = _B;
	cout << (A / B) << ".";
	A %= B;
	for (int i = 1;i <= 20;++ i) {
		A *= 10ll;
		cout << (A / B);
		A %= B;
	}
	cout << endl;
}

int main(){
	freopen("shape.in","r",stdin);
	freopen("shape.out","w",stdout);
	
	scanf("%d",&N);
	for (int i = 1;i <= N;++ i) {
		scanf("%d",&a[i]);
		M[a[i]] = 1;
	}
	
	bh = 0;
	for (map < int , int > :: iterator ii = M.begin();ii != M.end();ii ++) ii -> second = ++ bh;
	for (int i = 1;i <= N;++ i) a[i] = M[a[i]];
	
	memset(sum,0,sizeof(sum));
	for (int i = 1;i <= N;++ i)	sum[i][a[i]] = 1;
	for (int i = 1;i <= N;++ i)
		for (int j = 1;j <= bh;++ j)
			sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + sum[i][j];
	
	S_123 = S_132 = S_213 = S_231 = S_312 = S_321 = 0ll;
	for (int i = 1;i <= N;++ i)	
		for (int j = i + 1;j <= N;++ j) 
			if (a[i] != a[j]) {
				if (a[i] > a[j]) {
					S_132 += (LL)(sum[i - 1][a[j] - 1]);
					S_321 += (LL)(sum[i - 1][bh] - sum[i - 1][a[i]]);
					S_231 += (LL)(sum[i - 1][a[i] - 1] - sum[i - 1][a[j]]);
				}
				else {
					S_123 += (LL)(sum[i - 1][a[i] - 1]);
					S_312 += (LL)(sum[i - 1][bh] - sum[i - 1][a[j]]);
					S_213 += (LL)(sum[i - 1][a[j] - 1] - sum[i - 1][a[i]]);
				}
			}
	
	ToT = S_123 + S_132 + S_213 + S_231 + S_312 + S_321;
	High_digit_output(S_123,ToT);
	High_digit_output(S_132,ToT);
	High_digit_output(S_213,ToT);
	High_digit_output(S_231,ToT);
	High_digit_output(S_312,ToT);
	High_digit_output(S_321,ToT);		

	return 0;
}
