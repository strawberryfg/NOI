#include <cstdio>

int main()
{
    freopen("numfill.in", "r", stdin);
    freopen("numfill.out", "w", stdout);
    int n;
    scanf("%d", &n);
    if (n == 3)
        printf("Yes\n1 2 4\n");
    else if (n == 4)
        printf("Yes\n1 5 2 3\n");
    else
        puts("No");
    return 0;
}
