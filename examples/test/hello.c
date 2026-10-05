#include <stdio.h>
#include <errno.h>
#include <err.h>

int main(int argc, char *argv[])
{
        int res = printf("Hello world\n");
        if (res < 0) err(errno, "Failed to print hello world");
        return 0;
}
