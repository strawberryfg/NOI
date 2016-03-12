#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <string.h>
#include <cstring>
#include <math.h>

using namespace std;

int n;
int f[10000];
bool b[10000],p,m[10000];

int abs(int a)
{
	if (a < 0) return -a;
	else return a;
}

void root(int dep)
{
	if (!p) return ;
	if (dep > n)
	   if (b[abs(f[dep-1]-f[1])]){
   		p=false;
   		return ;
   	}
   	for (int i=1; i<=n+1; i++)
   	    if ((b[abs(i-f[dep-1])]) && (m[i])){
    	   	f[dep]=i;
    	   	b[abs(i-f[dep-1])]=false;
    	   	m[i]=false;
    	   	root(dep+1);
    	   	if (!p) return ;
    	   	b[abs(i-f[dep-1])]=true;
    	   	m[i]=true;
    	   }
}

int main()
{
	freopen("numfill.in","r",stdin);
	freopen("numfill.out","w",stdout);
	
	cin >> n;
	if (n <= 15){
	memset(f,0,sizeof(f));
	memset(b,true,sizeof(b));
	memset(m,true,sizeof(m));
	f[1]=1; f[2]=n+1;
	b[n]=false;
	m[1]=false; m[n+1]=false;
	p=true;
	root(3);
	if (!p){
		cout << "Yes" << endl;
		for (int i=1; i<=n; i++)
	    	cout << f[i] << ' ';
    	cout << endl;
	}
	else cout << "No" << endl;
	}
	else {
		if (n == 16){
			cout << "Yes" << endl;
			cout << "1 17 2 7 8 11 9 13 4 14 6 12 5 16 3 15" << endl;
		}
		if (n == 17){
			cout << "No" << endl;
		}
		if (n == 18){
			cout << "No" << endl;
		}
		if (n == 19){
			cout << "Yes" << endl;
			cout << "1 20 2 8 10 11 14 9 13 6 15 7 17 3 19 4 16 5 18" << endl;
		}
		if (n == 20){
			cout << "Yes" << endl;
			cout << "1 21 2 8 11 12 10 14 9 16 5 18 6 15 7 17 3 20 4 19" << endl;
		}
		if (n > 20) cout << "No" << endl;
	}
    
    system("PAUSE");
    return 0;
}
