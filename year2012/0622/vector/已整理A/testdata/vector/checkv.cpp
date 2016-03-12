#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <queue>
#include <set>
#include <map>
#include <sstream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cmath>
using namespace std;
typedef long long ll;
#define pb push_back
#define mp make_pair
#define fi first
#define se second
#define FOR(i, s, t) for(i = (s); i < (t); i++)
#define RFOR(i, s, t) for(i = (s)-1; i >= (t); i--)

int a[100005], b[100005], c[100005], d[100005];
int main()
{
  int i,n,q,score;
  
  ll s1,s2,s3,s4,ta, tb, tc, td,yourans;
  freopen("check.txt","w",stdout);
  printf("Error!\n0\n");
  ta = tb = tc = td = 0;
  freopen("vector.in","r",stdin);
  scanf("%d", &n);
  for(i = 0; i < n; i++)
     scanf("%d%d%d%d", &a[i], &b[i], &c[i], &d[i]);
  freopen("vector.out","r",stdin);
  for(i = 0; i < n; i++){
    if(scanf("%d", &q) != 1 || (q != 1 && q != -1)){
      return 0;
    }
    ta += a[i]*q;
    tb += b[i]*q;
    tc += c[i]*q;
    td += d[i]*q;
  }
  yourans=ta*ta+tb*tb+tc*tc+td*td;
  freopen("vector.ans","r",stdin);
  cin>>s1>>s2>>s3>>s4;
  if (yourans>=s1) score=2;
  if (yourans>=s2) score=5;
  if (yourans>=s3) score=7;
  if (yourans==s4) score=10;
  if (yourans>s4) score=12;
  freopen("check.txt","w",stdout);
  printf("FC:\n%d\n",score);
  return 0;
}
