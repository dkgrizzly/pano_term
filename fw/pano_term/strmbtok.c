#include <string.h>
#include "strmbtok.h"

/*
 * Like strtok, but with quotes
 */
char *strmbtok ( char *input, const char *delimit, const char *openblock, const char *closeblock) {
    static char *token = NULL;
    char *lead = NULL;
    char *block = NULL;
    int iBlock = 0;
    int iBlockIndex = 0;

    if ( input != NULL) {
        token = input;
        lead = input;
    }
    else {
        lead = token;
        if ( *token == '\0') {
            lead = NULL;
        }
    }

    while ( *token != '\0') {
        // We are in a quote, is this a matching close quote character?
        if ( iBlock) {
            if ( closeblock[iBlockIndex] == *token) {
                iBlock = 0;
            }
            token++;
            continue;
        }

        // Is this a valid opening quote?
        if ( ( block = strchr ( openblock, *token)) != NULL) {
            iBlock = 1;
            iBlockIndex = block - openblock;
            token++;
            continue;
        }
        if ( strchr ( delimit, *token) != NULL) {
            *token = '\0';
            token++;
            break;
        }
        token++;
    }
    return lead;
}

/*
 * Remove quotes from quoted strings.
 */
void unquote(char *out, char *in) {
  char tmp_str[256];

  if(!in) return;
  if(!out) return;

  char *pout = tmp_str;
  char inQuote = 0;
  while(*in != 0) {
    if(inQuote && (*in == inQuote)) {
      inQuote = 0;
    } else if(!inQuote && (*in == '"')) {
      inQuote = '"';
    } else if(!inQuote && (*in == '\'')) {
      inQuote = '\'';
    } else {
      *pout = *in;
      pout++;
    }
    in++;
  }
  *pout = 0;

  // This way you can have out == in
  strcpy(out, tmp_str);
}

int parsecmdline(char *cmdline, char **argv) {
   int i = 0;

   if(cmdline == NULL)
      return 0;

   while((*cmdline == ' ') || (*cmdline == '\t'))
      cmdline++;

   if(!cmdline[0])
      return 0;

   argv[i] = strmbtok(cmdline, " ", "\"'", "\"'");
   while ((argv[i] != NULL) && (i < MAXARG)) {
      // unquote the previous argument (last argument is always NULL)
      unquote(argv[i], argv[i]);
      argv[++i] = strmbtok(NULL, " ", "\"'", "\"'");
   };

   return i;
}
