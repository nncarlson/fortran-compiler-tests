#include <stdio.h>
void c_function (void *arg) {
  if (arg == NULL)
      printf("\targ pointer is NULL in c_function\n");
  else
      printf("\targ pointer is not NULL in c_function; arg=%d\n",*(int*)arg);
}
