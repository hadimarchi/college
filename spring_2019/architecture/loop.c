#include <stdio.h>
int main(){
  int i, a[10], sum=0;
  for (i=0; i<10; i++)
  {
    a[i]=i;
    sum=sum+a[i];
  }
  printf("%d\n",sum);
  return 0;
}
