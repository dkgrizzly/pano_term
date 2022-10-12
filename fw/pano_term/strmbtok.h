#define MAXARG 8
char *strmbtok ( char *input, const char *delimit, const char *openblock, const char *closeblock);
void unquote(char *out, char *in);
int parsecmdline(char *cmdline, char **argv);
