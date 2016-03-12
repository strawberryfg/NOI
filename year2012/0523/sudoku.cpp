//program sudoku

#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<algorithm>

using namespace std;

int A[9][9],B[9][9];
int X[9],Y[9],P0[9],P1[9];
bool Found;
bool FlagX[9],FlagY[9];

void Rotate()
{
  int T[9][9];
  for(int i=0;i<9;i++)
    for(int j=0;j<9;j++)
      T[j][8-i]=B[i][j];
  for(int i=0;i<9;i++)
    for(int j=0;j<9;j++)
      B[i][j]=T[i][j];
}

void DFSY(int Depth)
{
  if(Depth==9)Found=true;
  if(Found)return;
  int x[9],y[9];
  for(int i=0;i<9;i++)x[i]=P0[i];
  for(int i=0;i<9;i++)y[i]=P1[i];
  for(int i=0;i<9;i++)
    if(!FlagY[i])
      {
        if((Depth%3)&&(i/3!=Y[Depth-1]/3))continue;
        FlagY[i]=true;
        Y[Depth]=i;
        bool OK=true;
        for(int j=0;j<9;j++)P0[j]=x[j];
        for(int j=0;j<9;j++)P1[j]=y[j];
        for(int j=0;j<9;j++)
          {
            int p=A[j][Depth],q=B[X[j]][i];
            if(q==-1)continue;
            if(P0[p]!=-1&&P0[p]!=q)OK=false;
            if(P1[q]!=-1&&P1[q]!=p)OK=false;
            P0[p]=q;P1[q]=p;
          }
        if(OK)DFSY(Depth+1);
        FlagY[i]=false;
      }
}

void DFSX(int Depth)
{
  if(Found)return;
  if(Depth==9)
    {
      memset(FlagY,0,sizeof(FlagY));
      for(int i=0;i<9;i++)P0[i]=-1;
      for(int i=0;i<9;i++)P1[i]=-1;
      DFSY(0);return;
    }
  for(int i=0;i<9;i++)
    if(!FlagX[i])
      {
        if((Depth%3)&&(i/3!=X[Depth-1]/3))continue;
        FlagX[i]=true;
        X[Depth]=i;
        DFSX(Depth+1);
        FlagX[i]=false;
      }
}

bool Check()
{
  memset(FlagX,0,sizeof(FlagX));
  Found=false;
  DFSX(0);
  return Found;
}

bool OK()
{
  bool Flag[9];
  for(int i=0;i<9;i++)
    {
      memset(Flag,0,sizeof(Flag));
      for(int j=0;j<9;j++)
        if(B[i][j]!=-1)
          {
            if(Flag[B[i][j]])return false;
            Flag[B[i][j]]=true;
          }
    }
  for(int j=0;j<9;j++)
    {
      memset(Flag,0,sizeof(Flag));
      for(int i=0;i<9;i++)
        if(B[i][j]!=-1)
          {
            if(Flag[B[i][j]])return false;
            Flag[B[i][j]]=true;
          }
    }
  for(int x=0;x<3;x++)
    for(int y=0;y<3;y++)
      {
        memset(Flag,0,sizeof(Flag));
        for(int i=0;i<3;i++)
          for(int j=0;j<3;j++)
            {
              int T=B[x*3+i][y*3+j];
              if(T==-1)continue;
              if(Flag[T])return false;
              Flag[T]=true;
            }
      }
  return true;
}

int main()
{
  freopen("sudoku.in","r",stdin);
  freopen("sudoku.out","w",stdout);
  int Test;scanf("%d",&Test);
  while(Test--)
    {
      for(int i=0;i<9;i++)
        for(int j=0;j<9;j++)
          {
            char c;
            while(c=getchar(),c<'0'||c>'9');
            A[i][j]=c-49;
          }
      for(int i=0;i<9;i++)
        for(int j=0;j<9;j++)
          {
            char c;
            while(c=getchar(),c<'0'||c>'9');
            B[i][j]=c-49;
          }
      if(!OK())
        {
          printf("No\n");
          continue;
        }
      bool Ans=Check();
      if(!Ans){Rotate();Ans=Check();}
      if(!Ans){Rotate();Ans=Check();}
      if(!Ans){Rotate();Ans=Check();}
      printf(Ans?"Yes\n":"No\n");
    }
  return 0;
}

