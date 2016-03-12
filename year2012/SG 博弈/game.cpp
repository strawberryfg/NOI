#include<iostream>
using namespace std;
const int maxn=1000010;
struct
{
    int step;//该组棋子放在楼梯编号为step上
    int size;//该楼梯上有size个棋子
}group[maxn];//连续棋子分在一组
int group_num;//组数
int n,m;
int nim;
int first()
{
    int sum=0;
    int next_group_size;
    for (int i=1;i<=group_num;i++)
        if (group[i].step&1)//奇楼梯上，直接往下移石子可否
        {
            if ((group[i].size^nim)<group[i].size) sum++;
        }
        else
            if (group[i].step!=2)//对于这题的特殊处理，如果在楼梯2上，移到楼梯1的话，对手就胜了
            {
                if (i==group_num || group[i+1].step+1!=group[i].step)
                    next_group_size=0;//下一步楼梯上的棋子数
                else
                    next_group_size=group[i+1].size;
                int cut=(next_group_size^nim)-next_group_size;//下一步奇楼梯需要的棋子数
                if (cut>0 && group[i].size>=cut) sum++;
            }
    return sum;
}
void solve()
{
    int cover,last_cover;//cover：当前有棋子的格子编号，last_cover：相连左边最近棋子的格子编号
    int size,left;//size：该组有多少个棋子，left：还有多少个棋子没有处理
    scanf("%d%d",&m,&n);
    nim=group_num=0;
    left=n;
    scanf("%d",&cover);
    while (1==1)
    {
        size=0;
        last_cover=cover;
        while (1==1)
        {
            size++;
            left--;
            if (left==0) break;
            scanf("%d",&cover);
            if (cover!=last_cover+1) break;
            last_cover=cover;
        }
        group_num++;
        group[group_num].size=size;
        group[group_num].step=m-last_cover-left;//画下图就知道了！！！
        if (group[group_num].step&1)//是否是奇楼梯
            nim^=group[group_num].size;
        if (left==0) break;
    }
    if (last_cover==m-1) printf("%d\n",size);
    else
        if (nim==0) printf("0\n");
        else printf("%d\n",first());
}
int main()
{
    freopen("data.in","r",stdin);
    freopen("data.out","w",stdout);
    solve();
    fclose(stdin);
    fclose(stdout);
    return 0;
}

