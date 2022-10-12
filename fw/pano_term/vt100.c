/**
   Modified for use with Panologic devices by Skip Hansen 8/2019

   This file is derived from the avr-vt100 project:
   https://github.com/mkschreder/avr-vt100
   Copyright: Martin K. Schröder (info@fortmax.se) 2014

   This file is part of FORTMAX.

   FORTMAX is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   FORTMAX is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with FORTMAX.  If not, see <http://www.gnu.org/licenses/>.

   Copyright: Martin K. Schröder (info@fortmax.se) 2014

*/
#include <stdint.h>
#include "string.h"
#include "vt100.h"
#include "printf.h"

// #define DEBUG_LOGGING
// #define VERBOSE_DEBUG_LOGGING
// #define LOG_TO_SERIAL
#include "log.h"


uint32_t color_8bit[256] = {
    0x000000, // black
    0x770000, // red
    0x007700, // green
    0x777700, // yellow
    0x000077, // blue
    0x770077, // magenta
    0x007777, // cyan
    0x777777, // light grey
    0x333333, // dark grey
    0xff0000, // red
    0x00ff00, // green
    0xffff00, // yellow
    0x0000ff, // blue
    0xff00ff, // magenta
    0x00ffff, // cyan
    0xffffff, // white
    0x000000, 0x000055, 0x000088, 0x0000aa, 0x0000dd, 0x0000ff,
    0x005500, 0x005555, 0x005588, 0x0055aa, 0x0055dd, 0x0055ff,
    0x008800, 0x008855, 0x008888, 0x0088aa, 0x0088dd, 0x0088ff,
    0x00aa00, 0x00aa55, 0x00aa88, 0x00aaaa, 0x00aadd, 0x00aaff,
    0x00dd00, 0x00dd55, 0x00dd88, 0x00ddaa, 0x00dddd, 0x00ddff,
    0x00ff00, 0x00ff55, 0x00ff88, 0x00ffaa, 0x00ffdd, 0x00ffff,
    0x550000, 0x550055, 0x550088, 0x5500aa, 0x5500dd, 0x5500ff,
    0x555500, 0x555555, 0x555588, 0x5555aa, 0x5555dd, 0x5555ff,
    0x558800, 0x558855, 0x558888, 0x5588aa, 0x5588dd, 0x5588ff,
    0x55aa00, 0x55aa55, 0x55aa88, 0x55aaaa, 0x55aadd, 0x55aaff,
    0x55dd00, 0x55dd55, 0x55dd88, 0x55ddaa, 0x55dddd, 0x55ddff,
    0x55ff00, 0x55ff55, 0x55ff88, 0x55ffaa, 0x55ffdd, 0x55ffff,
    0x880000, 0x880055, 0x880088, 0x8800aa, 0x8800dd, 0x8800ff,
    0x885500, 0x885555, 0x885588, 0x8855aa, 0x8855dd, 0x8855ff,
    0x888800, 0x888855, 0x888888, 0x8888aa, 0x8888dd, 0x8888ff,
    0x88aa00, 0x88aa55, 0x88aa88, 0x88aaaa, 0x88aadd, 0x88aaff,
    0x88dd00, 0x88dd55, 0x88dd88, 0x88ddaa, 0x88dddd, 0x88ddff,
    0x88ff00, 0x88ff55, 0x88ff88, 0x88ffaa, 0x88ffdd, 0x88ffff,
    0xaa0000, 0xaa0055, 0xaa0088, 0xaa00aa, 0xaa00dd, 0xaa00ff,
    0xaa5500, 0xaa5555, 0xaa5588, 0xaa55aa, 0xaa55dd, 0xaa55ff,
    0xaa8800, 0xaa8855, 0xaa8888, 0xaa88aa, 0xaa88dd, 0xaa88ff,
    0xaaaa00, 0xaaaa55, 0xaaaa88, 0xaaaaaa, 0xaaaadd, 0xaaaaff,
    0xaadd00, 0xaadd55, 0xaadd88, 0xaaddaa, 0xaadddd, 0xaaddff,
    0xaaff00, 0xaaff55, 0xaaff88, 0xaaffaa, 0xaaffdd, 0xaaffff,
    0xdd0000, 0xdd0055, 0xdd0088, 0xdd00aa, 0xdd00dd, 0xdd00ff,
    0xdd5500, 0xdd5555, 0xdd5588, 0xdd55aa, 0xdd55dd, 0xdd55ff,
    0xdd8800, 0xdd8855, 0xdd8888, 0xdd88aa, 0xdd88dd, 0xdd88ff,
    0xddaa00, 0xddaa55, 0xddaa88, 0xddaaaa, 0xddaadd, 0xddaaff,
    0xdddd00, 0xdddd55, 0xdddd88, 0xddddaa, 0xdddddd, 0xddddff,
    0xddff00, 0xddff55, 0xddff88, 0xddffaa, 0xddffdd, 0xddffff,
    0xff0000, 0xff0055, 0xff0088, 0xff00aa, 0xff00dd, 0xff00ff,
    0xff5500, 0xff5555, 0xff5588, 0xff55aa, 0xff55dd, 0xff55ff,
    0xff8800, 0xff8855, 0xff8888, 0xff88aa, 0xff88dd, 0xff88ff,
    0xffaa00, 0xffaa55, 0xffaa88, 0xffaaaa, 0xffaadd, 0xffaaff,
    0xffdd00, 0xffdd55, 0xffdd88, 0xffddaa, 0xffdddd, 0xffddff,
    0xffff00, 0xffff55, 0xffff88, 0xffffaa, 0xffffdd, 0xffffff,
    0x000000, 0x111111, 0x112211, 0x222222, 0x333333, 0x334433,
    0x444444, 0x555555, 0x556655, 0x666666, 0x777777, 0x778877,
    0x888888, 0x999999, 0x99aa99, 0xaaaaaa, 0xbbbbbb, 0xbbccbb,
    0xcccccc, 0xdddddd, 0xddeedd, 0xeeeeee, 0xeeffee, 0xffffff
};


#define abs(x) (x < 0 ? -x : x)
#define isdigit(x) (x >= '0' && x <= '9')

#define VRAM_ADR 0x98000500
#define SCREEN_X 160
#define SCREEN_Y 64

#define CURSOR_CHAR     0x5F

#define KEY_ESC 0x1b
#define KEY_DEL 0x7f
#define KEY_BELL 0x07

#define STATE(NAME, TERM, EV, ARG) void NAME(vt100_t *TERM, uint8_t EV, uint16_t ARG)

// states
enum {
   STATE_IDLE,
   STATE_ESCAPE,
   STATE_COMMAND
};

// events that are passed into states
enum {
   EV_CHAR = 1,
};

#define MAX_COMMAND_ARGS 16

typedef struct vt100_s {
   union flags {
      uint8_t val;
      struct {
         // 0 = cursor remains on last column when it gets there
         // 1 = lines wrap after last column to next line
         uint8_t cursor_wrap : 1;
         uint8_t scroll_mode : 1;
         uint8_t origin_mode : 1;
      };
   } flags;

   // cursor position on the screen (0, 0) = top left corner.
   uint8_t cursor_char;
   int16_t screen_w, screen_h, screen_skew;
   int16_t cursor_x, cursor_y;
   int16_t saved_cursor_x, saved_cursor_y; // used for cursor save restore
   int16_t scroll_start_row, scroll_end_row;
   // character width and height
   int8_t char_width, char_height;
   // colors used for rendering current characters
   uint32_t back_color, front_color;
   // command arguments that get parsed as they appear in the terminal
   uint8_t narg; uint16_t args[MAX_COMMAND_ARGS];
   // current arg pointer (we use it for parsing)
   uint8_t carg;

   void (*state)(struct vt100_s *term, uint8_t ev, uint16_t arg);
   void (*ret_state)(struct vt100_s *term, uint8_t ev, uint16_t arg);

// Pano memory mapped screen. Only the bottom 56 bits are actually implemented
   uint64_t *VRam;
   uint64_t CharUnderCursor;
} vt100_t;

static vt100_t term;
static vt100_t status;

STATE(_st_idle, t, ev, arg);
STATE(_st_esc_sq_bracket, t, ev, arg);
STATE(_st_esc_question, t, ev, arg);
STATE(_st_esc_hash, t, ev, arg);

void _vt100_reset(void)
{
   term.back_color = 0x000000;
   term.front_color = 0x777777;
   term.screen_w = VT100_WIDTH;
   term.screen_h = VT100_HEIGHT;
   term.screen_skew = SCREEN_X;
   term.cursor_char = CURSOR_CHAR;
   term.cursor_x = term.cursor_y = term.saved_cursor_x = term.saved_cursor_y = 0;
   term.narg = 0;
   term.state = _st_idle;
   term.ret_state = 0;
   term.scroll_start_row = 0;
   term.scroll_end_row = VT100_HEIGHT; // outside of screen = whole screen scrollable
   term.flags.cursor_wrap = 0;
   term.flags.origin_mode = 0;
   term.VRam = (uint64_t *) 0x98000500;

   status.back_color = 0x000000;
   status.front_color = 0x777777;
   status.screen_w = VT100_WIDTH;
   status.screen_h = 1;
   status.screen_skew = SCREEN_X;
   status.cursor_char = 0;
   status.cursor_x = status.cursor_y = status.saved_cursor_x = status.saved_cursor_y = 0;
   status.narg = 0;
   status.state = _st_idle;
   status.ret_state = 0;
   status.scroll_start_row = 0;
   status.scroll_end_row = 1; // outside of screen = whole screen scrollable
   status.flags.cursor_wrap = 0;
   status.flags.origin_mode = 0;
   status.VRam = (uint64_t *) 0x98000000;
}

void _vt100_resetScroll(void)
{
   term.scroll_start_row = 0;
   term.scroll_end_row = VT100_HEIGHT;

   status.scroll_start_row = 0;
   status.scroll_end_row = 1;
}

// clear screen from start_line to end_line (including end_line)
void _vt100_clearLines(vt100_t *t, uint16_t start_line, uint16_t end_line)
{
   int Len = (end_line - start_line + 1) * t->screen_skew;
   int Start = start_line * t->screen_skew;
   int i;
   uint64_t *p;

   LOG("start_line: %d, end_line: %d\n",start_line,end_line);
   LOG("Start: %d, Len: %d\n",Start,Len);
   if(Len - Start > (t->screen_skew * t->screen_h) ) {
      // limit to the end of the screen
      Len = (t->screen_skew * t->screen_h) - Start;
   }

   p = (uint64_t *) &t->VRam[Start];
   LOG("Start: %d, Len: %d\n",Start,Len);

   while(Len > 0) {
      for(i = 0; (i<t->screen_skew) && (Len>0); i++, Len--) {
         *p++ = ' ';
      }
   }
   if(p > &t->VRam[t->screen_skew * t->screen_h]) {
      ELOG("Past end of VRam, p: 0x%x\n", (uint32_t) p);
      for( ; ; );
   }
}

// clear line from cursor right/left
void _vt100_clearLine(vt100_t *t)
{
   int Len;
   int Start;
   int i;
   uint64_t *p;

   if(t->narg == 0 || (t->narg == 1 && t->args[0] == 0)) {
   // clear to end of line (to \n or to edge?)
   // including cursor
      Start = (t->cursor_y * t->screen_skew) + t->cursor_x;
      Len = t->screen_w - t->cursor_x;
   }
   else if(t->narg == 1 && t->args[0] == 1) {
   // clear from left to current cursor position
      Start = (t->cursor_y * t->screen_skew);
      Len = t->cursor_x;
   }
   else if(t->narg == 1 && t->args[0] == 2) {
   // clear whole current line
      Start = (t->cursor_y * t->screen_skew);
      Len = t->screen_w;
   }
   p = (uint64_t *) &t->VRam[Start];

   while(Len > 0) {
      for(i = 0; (i<t->screen_skew) && (Len>0); i++, Len--) {
         *p++ = ' ';
      }
   }
   if(p > &t->VRam[t->screen_skew * t->screen_h]) {
      ELOG("Past end of VRAM\n");
      for( ; ; );
   }
   t->state = _st_idle;
}

// scrolls the scroll region up (lines > 0) or down (lines < 0)
void _vt100_scroll(vt100_t *t, int16_t lines)
{
   int Start;
   int Len;
   int i;
   char *cp;
   char *cp1;
   uint64_t *pFrom;
   uint64_t *pTo;
   int OffsetTop;

   if(!lines) return;

   OffsetTop = t->screen_skew * t->scroll_start_row;
   LOG("lines: %d OffsetTop: %d\n",lines,OffsetTop);

   // clearing of lines that we have scrolled up or down
   if(lines > 0) {
      Len = t->screen_skew * (t->screen_h - lines);
      LOG("Len: %d\n",Len);
      pTo = (uint64_t *) &t->VRam[OffsetTop];
      pFrom = pTo + (t->screen_skew * lines);
      i = Len;

      LOG("from 0x%x to 0x%x, len: %d, t->VRam: 0x%x\n",
          (uint32_t) pFrom,(uint32_t) pTo,i,
          (uint32_t) t->VRam);

      while(i-- > 0) {
         *pTo++ = *pFrom++;
      }
      if(pTo > &t->VRam[t->screen_skew * t->screen_h]) {
         ELOG("Past end of VRam\n");
         for( ; ; );
      }
      _vt100_clearLines(t,t->scroll_end_row-(lines-1)-1,t->scroll_end_row-1);
   }
   else if(lines < 0) {
#if 0
      // update the scroll value (wraps around scroll_height)
      Len = t->screen_skew * (t->screen_h - lines);
      pFrom = &t->VRam[OffsetTop];
      pTo = pFrom + (t->screen_skew * lines);
      i = Len;

      while(Len > 0) {
         for(i = 0; (i<t->screen_w) && (Len>0); i++, Len--) {
            *pTo++ = *cp++;
         }
         pTo += t->screen_skew - t->screen_w;
      }
      _vt100_clearLines(t, t->scroll_end_row - lines, t->scroll_end_row - 1);
      // make sure that the value wraps down
      Len = t->screen_w * -lines;
#endif
   }
}

// moves the cursor relative to current cursor position and scrolls the screen
void _vt100_move(vt100_t *t, int16_t DeltaX, int16_t DeltaY)
{
   // calculate how many lines we need to move down or up if x movement goes outside screen
   int16_t new_x = DeltaX + t->cursor_x;

   if(new_x >= t->screen_w) {
      if(t->flags.cursor_wrap) {
      // 1 = lines wrap after last column to next line
         DeltaY += new_x / t->screen_w;
         t->cursor_x = new_x % t->screen_w;
      }
      else {
      // 0 = cursor remains on last column when it gets there
         t->cursor_x = t->screen_w - 1;
      }
   }
   else if(new_x < 0) {
      DeltaY += new_x / t->screen_w - 1;
      t->cursor_x = t->screen_w - (abs(new_x) % t->screen_w) + 1;
   }
   else {
      t->cursor_x = new_x;
   }

   if(DeltaY) {
      int16_t new_y = t->cursor_y + DeltaY;
      int16_t to_scroll = 0;
      // bottom margin 39 marks last line as static on 40 line display
      // therefore, we would scroll when new cursor has moved to line 39
      // (or we could use new_y > t->screen_h here
      // NOTE: new_y >= t->scroll_end_row ## to_scroll = (new_y - t->scroll_end_row) +1
      if(new_y >= t->scroll_end_row) {
         //scroll = new_y / t->screen_h;
         //t->cursor_y = t->screen_h;
         to_scroll = (new_y - t->scroll_end_row) + 1;
         // place cursor back within the scroll region
         t->cursor_y = t->scroll_end_row - 1; //new_y - to_scroll;
         //scroll = new_y - t->bottom_margin;
         //t->cursor_y = t->bottom_margin;
      }
      else if(new_y < t->scroll_start_row) {
         to_scroll = (new_y - t->scroll_start_row);
         t->cursor_y = t->scroll_start_row; //new_y - to_scroll;
         //scroll = new_y / (t->bottom_margin - t->top_margin) - 1;
         //t->cursor_y = t->top_margin;
      }
      else {
         // otherwise we move as normal inside the screen
         t->cursor_y = new_y;
      }
      _vt100_scroll(t, to_scroll);
   }
}

void _vt100_removeCursor(vt100_t *t)
{
   uint64_t Char = t->CharUnderCursor;

   if(Char != 0) {
      int Offset = (t->cursor_y * t->screen_skew) + t->cursor_x;
      t->VRam[Offset] = (uint64_t) Char;
      t->CharUnderCursor = 0;
      if(&t->VRam[Offset] >= &t->VRam[t->screen_skew * t->screen_h]) {
         ELOG("Past end of VRam\n");
         for( ; ; );
      }
   }
}

void _vt100_drawCursor(vt100_t *t)
{
   int Offset = (t->cursor_y * t->screen_skew) + t->cursor_x;

   t->CharUnderCursor = t->VRam[Offset];

   if(t->cursor_char != 0)
      t->VRam[Offset] = (((uint64_t)t->back_color) << 40) | (((uint64_t)t->front_color) << 8) | (t->cursor_char);
}

// sends the character to the display and updates cursor position
void _vt100_putc(vt100_t *t, uint8_t ch)
{
   // calculate current cursor position in the display ram
   int Offset = (t->cursor_y * t->screen_skew) + t->cursor_x;
   t->VRam[Offset] = (((uint64_t)t->back_color) << 40) | (((uint64_t)t->front_color) << 8) | ch;
   t->CharUnderCursor = 0;

   if(&t->VRam[Offset] >= &t->VRam[t->screen_skew * t->screen_h]) {
      ELOG("Past end of VRam\n");
      for( ; ; );
   }

   // move cursor right
   _vt100_move(t, 1, 0);
}

STATE(_st_command_arg, t, ev, arg){
   switch(ev) {
      case EV_CHAR:
         if(isdigit(arg)) { // a digit argument
            t->args[t->narg] = t->args[t->narg] * 10 + (arg - '0');
         }
         else if(arg == ';') { // separator
            t->narg++;
         }
         else { // no more arguments
            // go back to command state
            t->narg++;
            if(t->ret_state) {
               t->state = t->ret_state;
            }
            else {
               t->state = _st_idle;
            }
            // execute next state as well because we have already consumed a char!
            t->state(t, ev, arg);
         }
         break;
   }
}

STATE(_st_esc_sq_bracket, t, ev, arg)
{
   switch(ev) {
      case EV_CHAR:
         if(isdigit(arg)) { // start of an argument
            t->ret_state = _st_esc_sq_bracket;
            _st_command_arg(t, ev, arg);
            t->state = _st_command_arg;
         }
         else if(arg == ';') { // arg separator.
            // skip. And also stay in the command state
         }
         else {
         // otherwise we execute the command and go back to idle
            _vt100_removeCursor(t);
            switch(arg) {
               case 'A': {
               // move cursor up (cursor stops at top margin)
                  int n = (t->narg > 0)?t->args[0]:1;
                  t->cursor_y -= n;
                  if(t->cursor_y < 0) t->cursor_y = 0;
                  t->state = _st_idle;
                  break;
               }
               case 'B': {
               // cursor down (cursor stops at bottom margin)
                  int n = (t->narg > 0)?t->args[0]:1;
                  t->cursor_y += n;
                  if(t->cursor_y > t->screen_h) t->cursor_y = t->screen_h;
                  t->state = _st_idle;
                  break;
               }
               case 'C': {
               // cursor right (cursor stops at right margin)
                  int n = (t->narg > 0)?t->args[0]:1;
                  t->cursor_x += n;
                  if(t->cursor_x > t->screen_w) t->cursor_x = t->screen_w;
                  t->state = _st_idle;
                  break;
               }
               case 'D': {
               // cursor left
                  int n = (t->narg > 0)?t->args[0]:1;
                  t->cursor_x -= n;
                  if(t->cursor_x < 0) t->cursor_x = 0;
                  t->state = _st_idle;
                  break;
               }
               case 'f':
               case 'H':
               // move cursor to position (default 0;0)
            // cursor stops at respective margins
                  t->cursor_x = (t->narg >= 1)?(t->args[1]-1):0;
                  t->cursor_y = (t->narg == 2)?(t->args[0]-1):0;
                  if(t->flags.origin_mode) {
                     t->cursor_y += t->scroll_start_row;
                     if(t->cursor_y >= t->scroll_end_row) {
                        t->cursor_y = t->scroll_end_row - 1;
                     }
                  }
                  if(t->cursor_x > t->screen_w) t->cursor_x = t->screen_w;
                  if(t->cursor_y > t->screen_h) t->cursor_y = t->screen_h;
                  t->state = _st_idle;
                  break;

               case 'J':
               // clear screen from cursor up or down
                  if(t->narg == 0 || (t->narg == 1 && t->args[0] == 0)) {
                     // clear down to the bottom of screen (including cursor)
                     _vt100_clearLines(t, t->cursor_y, t->screen_h-1);
                  }
                  else if(t->narg == 1 && t->args[0] == 1) {
                     // clear top of screen to current line (including cursor)
                     _vt100_clearLines(t, 0, t->cursor_y);
                  }
                  else if(t->narg == 1 && t->args[0] == 2) {
                     // clear whole screen
                     _vt100_clearLines(t, 0, t->screen_h-1);
                     // reset scroll value
                     _vt100_resetScroll();
                  }
                  t->state = _st_idle;
                  break;

               case 'K':
               // clear line from cursor right/left
                  _vt100_clearLine(t);
                  break;

               case 'L': // insert lines (args[0] = number of lines)
               case 'M': // delete lines (args[0] = number of lines)
                  t->state = _st_idle;
                  break;

               case 'P': {
               // delete characters args[0] or 1 in front of cursor
                  // TODO: this needs to correctly delete n chars
                  int n = ((t->narg > 0)?t->args[0]:1);
                  _vt100_move(t, -n, 0);
                  for(int c = 0; c < n; c++) {
                     _vt100_putc(t, ' ');
                  }
                  t->state = _st_idle;
                  break;
               }
               case 'c':
               // query device code
                  t->state = _st_idle;
                  break;

               case 'x':
                  t->state = _st_idle;
                  break;

               case 's': // save cursor pos
                     t->saved_cursor_x = t->cursor_x;
                     t->saved_cursor_y = t->cursor_y;
                     t->state = _st_idle;
                     break;

               case 'u': // restore cursor pos
                     t->cursor_x = t->saved_cursor_x;
                     t->cursor_y = t->saved_cursor_y;
                     //_vt100_moveCursor(t, t->saved_cursor_x, t->saved_cursor_y);
                     t->state = _st_idle;
                     break;

               case 'h':
               case 'l':
                     t->state = _st_idle;
                     break;

               case 'g':
                     t->state = _st_idle;
                     break;

               case 'm': // sets colors. Accepts up to 3 args
                     // [m means reset the colors to default
                     if(!t->narg) {
                        t->front_color = 0xffffff;
                        t->back_color = 0x000000;
                     }
                     while(t->narg) {
                        if((t->narg >= 5) && (t->args[0] == 38) && (t->args[1] == 2)) {
                           t->front_color = (t->args[2] << 16) | (t->args[3] << 8) | (t->args[4] << 0);
                           t->narg -= 5;
                           if(t->narg > 0)
                              memcpy(&t->args[0], &t->args[5], sizeof(unsigned short)*(t->narg));
                        } else
                        if((t->narg >= 5) && (t->args[0] == 48) && (t->args[1] == 2)) {
                           t->back_color = (t->args[2] << 16) | (t->args[3] << 8) | (t->args[4] << 0);
                           t->narg -= 5;
                           if(t->narg > 0)
                              memcpy(&t->args[0], &t->args[5], sizeof(unsigned short)*(t->narg));
                        } else
                        if((t->narg >= 3) && (t->args[0] == 38) && (t->args[1] == 5)) {
                           t->front_color = color_8bit[t->args[2] & 0xff];
                           t->narg -= 3;
                           if(t->narg > 0)
                              memcpy(&t->args[0], &t->args[3], sizeof(unsigned short)*(t->narg));
                        } else
                        if((t->narg >= 3) && (t->args[0] == 48) && (t->args[1] == 5)) {
                           t->back_color = color_8bit[t->args[2] & 0xff];
                           t->narg -= 3;
                           if(t->narg > 0)
                              memcpy(&t->args[0], &t->args[3], sizeof(unsigned short)*(t->narg));
                        } else {
                           t->narg--;
                           int n = t->args[t->narg];
                           if(n == 0) { // all attributes off
                              t->front_color = 0x777777;
                              t->back_color = 0x000000;
                           //   t->attribute = 0;
                           }
                           if(n == 1) { // bold
                              t->front_color |= 0x808080;
                           }
                           if(n == 4) { // underline (blue)
                              t->front_color = 0x3f3f7f;
                           }
                           //if(n == 5) { // blink
                           //   t->attribute |= ATR_BLINK;
                           //}
                           if(n == 7) { // inverse
                              t->front_color = 0x000000;
                              t->back_color = 0x777777;
                           //   t->attribute |= ATR_INVERSE;
                           }
                           if(n >= 30 && n < 38) { // fg colors
                              t->front_color = color_8bit[n-30];
                           }
                           else if(n >= 40 && n < 48) {
                              t->back_color = color_8bit[n-40];
                           }
                        }
                     }
                     t->state = _st_idle;
                     break;

               case '@': // Insert Characters
                  t->state = _st_idle;
                  break;

               case 'r': // Set scroll region (top and bottom margins)
                  // the top value is first row of scroll region
                  // the bottom value is the first row of static region after scroll
                  if(t->narg == 2 && t->args[0] < t->args[1]) {
                     // [1;40r means scroll region between 8 and 312
                     // bottom margin is 320 - (40 - 1) * 8 = 8 pix
                     t->scroll_start_row = t->args[0] - 1;
                     t->scroll_end_row = t->args[1] - 1;
                     LOG("Setting scroll region to %d/%d\n",
                         t->scroll_start_row,t->scroll_end_row);
                  }
                  else {
                     _vt100_resetScroll();
                  }
                  t->state = _st_idle;
                  break;

               case 'q':
               // Set LEDs on status line
                  if(t->narg == 1 && t->args[0] == 0) {
                     status_printf("\x1b[1;120H\x1b[m                    \r");
                  }
                  else if(t->narg == 1 && t->args[0] == 1) {
                     status_printf("\x1b[1;120H\x1b[m\xde\xdb\xdb\xdb\xdd\r");
                  }
                  else if(t->narg == 1 && t->args[0] == 2) {
                     status_printf("\x1b[1;125H\x1b[m\xde\xdb\xdb\xdb\xdd\r");
                  }
                  else if(t->narg == 1 && t->args[0] == 3) {
                     status_printf("\x1b[1;130H\x1b[m\xde\xdb\xdb\xdb\xdd\r");
                  }
                  else if(t->narg == 1 && t->args[0] == 4) {
                     status_printf("\x1b[1;135H\x1b[m\xde\xdb\xdb\xdb\xdd\r");
                  }
                  t->state = _st_idle;
                  break;

               case 'i': // Printing
               case 'y': // self test modes..
               case '=': // argument follows...
                  //t->state = _st_screen_mode;
                  t->state = _st_idle;
                  break;

               case '?': // '[?' escape mode
                  t->state = _st_esc_question;

                  break;
               default: // unknown sequence
                     t->state = _st_idle;
                     break;
            }
            _vt100_drawCursor(t);

            //t->state = _st_idle;
         } // else
         break;
      default: { // switch (ev)
            // for all other events restore normal mode
            t->state = _st_idle;
         }
   }
}

STATE(_st_esc_question, t, ev, arg)
{
   // DEC mode commands
   switch(ev) {
      case EV_CHAR:
         if(isdigit(arg)) { // start of an argument
            t->ret_state = _st_esc_question;
            _st_command_arg(t, ev, arg);
            t->state = _st_command_arg;
         }
         else if(arg == ';') { // arg separator.
            // skip. And also stay in the command state
         }
         else {
            switch(arg) {
               case 'l':
                  // dec mode: OFF (arg[0] = function)
               case 'h': {
                     // dec mode: ON (arg[0] = function)
                     switch(t->args[0]) {
                        case 1: { // cursor keys mode
                              // h = esc 0 A for cursor up
                              // l = cursor keys send ansi commands
                              status_printf("\x1b[1;140H\x1b[%dm \xae%c\xaf \r", (arg == 'h'), (arg == 'h') ? 'A' : 'C');
                              break;
                           }
                        case 2: { // ansi / vt52
                              // h = ansi mode
                              // l = vt52 mode
                              status_printf("\x1b[1;114H\x1b[%dm %s \r", (arg == 'h'), (arg == 'h') ? "ANSI" : "VT52");
                              break;
                           }
                        case 3: {
                              // h = 132 chars per line
                              // l = 80 chars per line
                              status_printf("\x1b[1;108H\x1b[%dm %s \r", (arg == 'h'), (arg == 'h') ? " 132" : " 80 ");
                              break;
                           }
                        case 4: {
                              // h = smooth scroll
                              // l = jump scroll
                              break;
                           }
                        case 5: {
                              // h = black on white bg
                              // l = white on black bg
                              status_printf("\x1b[1;96H\x1b[%dm %s \r", (arg == 'h'), (arg == 'h') ? " INV" : "NRML");
                              break;
                           }
                        case 6: {
                              // h = cursor relative to scroll region
                              // l = cursor independent of scroll region
                              t->flags.origin_mode = (arg == 'h')?1:0;
                              break;
                           }
                        case 7: {
                              // h = new line after last column
                              // l = cursor stays at the end of line
                              t->flags.cursor_wrap = (arg == 'h')?1:0;
                              break;
                           }
                        case 8: {
                              // h = keys will auto repeat
                              // l = keys do not auto repeat when held down
                              break;
                           }
                        case 9: {
                              // h = display interlaced
                              // l = display not interlaced
                              break;
                           }
                           // 10-38 - all quite DEC speciffic commands so omitted here
                     }
                     t->state = _st_idle;
                     break;
                  }
               case 'i': /* Printing */
               case 'n': /* Request printer status */
               default:
                  t->state = _st_idle;
                  break;
            }
            t->state = _st_idle;
         }
   }
}

STATE(_st_esc_left_br, t, ev, arg){
   switch(ev) {
      case EV_CHAR:
         switch(arg) {
            case 'A':
            case 'B':
               // translation map command?
            case '0':
            case 'O':
               // another translation map command?
               t->state = _st_idle;
               break;
            default:
               t->state = _st_idle;
         }
         //t->state = _st_idle;
   }
}

STATE(_st_esc_right_br, t, ev, arg)
{
   switch(ev) {
      case EV_CHAR:
         switch(arg) {
            case 'A':
            case 'B':
               // translation map command?
            case '0':
            case 'O':
               // another translation map command?
               t->state = _st_idle;
               break;
            default:
               t->state = _st_idle;
         }
         break;
   }
}

STATE(_st_esc_hash, t, ev, arg)
{
   switch(ev) {
      case EV_CHAR:
         switch(arg) {
            case '8': {
                  // self test: fill the screen with 'E'

                  t->state = _st_idle;
                  break;
               }
            default:
               t->state = _st_idle;
         }
   }
}

STATE(_st_escape, t, ev, arg)
{
#define CLEAR_ARGS \
            { t->narg = 0;\
            for(int c = 0; c < MAX_COMMAND_ARGS; c++)\
               t->args[c] = 0; }
   switch(ev) {
      case EV_CHAR:
         _vt100_removeCursor(t);
         switch(arg) {
            case '[': // command
               // prepare command state and switch to it
               CLEAR_ARGS;
               t->state = _st_esc_sq_bracket;
               break;

            case '(': /* ESC ( */
               CLEAR_ARGS;
               t->state = _st_esc_left_br;
               break;
            case ')': /* ESC ) */
               CLEAR_ARGS;
               t->state = _st_esc_right_br;
               break;
            case '#': // ESC #
               CLEAR_ARGS;
               t->state = _st_esc_hash;
               break;
            case 'P': //ESC P (DCS, Device Control String)
               t->state = _st_idle;
               break;
            case 'D': // moves cursor down one line and scrolls if necessary
               // move cursor down one line and scroll window if at bottom line
               _vt100_move(t, 0, 1);
               t->state = _st_idle;
               break;
            case 'M': // Cursor up
               // move cursor up one line and scroll window if at top line
               _vt100_move(t, 0, -1);
               t->state = _st_idle;
               break;
            case 'E': // next line
               // same as '\r\n'
               _vt100_move(t, 0, 1);
               t->cursor_x = 0;
               t->state = _st_idle;
               break;
            case '7': // Save attributes and cursor position
            case 's':
               t->saved_cursor_x = t->cursor_x;
               t->saved_cursor_y = t->cursor_y;
               t->state = _st_idle;
               break;
            case '8': // Restore them
            case 'u':
               t->cursor_x = t->saved_cursor_x;
               t->cursor_y = t->saved_cursor_y;
               t->state = _st_idle;
               break;
            case '=': // Keypad into applications mode
               status_printf("\x1b[1;145H\x1b[0m APP \r");
               t->state = _st_idle;
               break;
            case '>': // Keypad into numeric mode
               status_printf("\x1b[1;145H\x1b[1m NUM \r");
               t->state = _st_idle;
               break;
            case 'Z': // Report tinal type
               // vt 100 response
               t->state = _st_idle;
               break;
            case 'c': // Reset tinal to initial state
               _vt100_reset();
               t->state = _st_idle;
               break;
            case 'H': // Set tab in current position
            case 'N': // G2 character set for next character only
            case 'O': // G3 "               "
               // ignore
               t->state = _st_idle;
               break;
            case '<': // Exit vt52 mode
               // ignore
               status_printf("\x1b[1;114H\x1b[1m ANSI \r");
               t->state = _st_idle;
               break;
            case KEY_ESC: { // marks start of next escape sequence
                  // stay in escape state
                  break;
               }
            default: { // unknown sequence - return to normal mode
                  t->state = _st_idle;
                  break;
               }
         }
         _vt100_drawCursor(t);
         break;
      default: {
            // for all other events restore normal mode
            t->state = _st_idle;
         }
   }
#undef CLEAR_ARGS
}

STATE(_st_idle, t, ev, arg)
{
   switch(ev) {
      case EV_CHAR: {
            _vt100_removeCursor(t);
            switch(arg) {
               case 5: // AnswerBack for vt100's
                  break;
               case '\n': { // new line
                     _vt100_move(t, 0, 1);
                     t->cursor_x = 0;
                     //_vt100_moveCursor(t, 0, t->cursor_y + 1);
                     // do scrolling here!
                     break;
                  }
               case '\r': { // carrage return (0x0d)
                     t->cursor_x = 0;
                     //_vt100_move(t, 0, 1);
                     //_vt100_moveCursor(t, 0, t->cursor_y);
                     break;
                  }
               case '\b': { // backspace 0x08
                     _vt100_move(t, -1, 0);
                     // backspace does not delete the character! Only moves cursor!
                     //ili9340_drawChar(t->cursor_x * t->char_width,
                     // t->cursor_y * t->char_height, ' ');
                     break;
                  }
               case KEY_DEL: { // del - delete character under cursor
                     // Problem: with current implementation, we can't move the rest of line
                     // to the left as is the proper behavior of the delete character
                     // fill the current position with background color
                     _vt100_putc(t, ' ');
                     _vt100_move(t, -1, 0);
                     //_vt100_clearChar(t, t->cursor_x, t->cursor_y);
                     break;
                  }
               case '\t': { // tab
                     // tab fills characters on the line until we reach a multiple of tab_stop
                     int tab_stop = 4;
                     int to_put = tab_stop - (t->cursor_x % tab_stop);
                     while(to_put--) _vt100_putc(t, ' ');
                     break;
                  }
               case KEY_BELL: { // bell is sent by bash for ex. when doing tab completion
                     // sound the speaker bell?
                     // skip
                     break;
                  }
               case KEY_ESC: // escape
                  t->state = _st_escape;
                  break;

               default: {
                     _vt100_putc(t, arg);
                     break;
                  }
            }
            _vt100_drawCursor(t);
            break;
         }
      default: {}
   }
}

void memset64(uint64_t *p, uint64_t v, uint32_t s) {
   while(s) {
      *p=v;
      p++;
      s--;
   }
}

void vt100_init()
{
   _vt100_reset();
   memset64(term.VRam, (0x777777 << 8) | ' ',term.screen_skew * term.screen_h);
   memset64(status.VRam, (0x777777 << 8) | ' ',status.screen_skew * status.screen_h);
}

void vt100_putc(uint8_t c)
{
   term.state(&term, EV_CHAR, 0x0000 | c);
   status_flush();
}

void vt100_puts(const char *str)
{
   while(*str) {
      vt100_putc(*str++);
   }
}

uint8_t vt100_stream_buffer[2048];
uint16_t vt100_stream_ptr = 0;

void vt100_flush()
{
   uint16_t i;
   for(i = 0; i < vt100_stream_ptr; i++) {
      vt100_putc(vt100_stream_buffer[i]);
   }
   vt100_stream_ptr = 0;
}

void vt100_buffer(uint8_t c)
{
   if(vt100_stream_ptr == sizeof(vt100_stream_buffer)) {
      vt100_flush();
      vt100_stream_ptr = 0;
   }
   vt100_stream_buffer[vt100_stream_ptr++] = c;
}

void vt100_printf(const char *Format, ...)
{
   int Len;
   int MaxLen = sizeof(vt100_stream_buffer) - vt100_stream_ptr;
   va_list Args;

   va_start(Args,Format);

   Len = vsnprintf((vt100_stream_buffer + vt100_stream_ptr),MaxLen,Format,Args);
   vt100_stream_ptr += Len;
}

void status_putc(uint8_t c)
{
   status.state(&status, EV_CHAR, 0x0000 | c);
}

void status_puts(const char *str)
{
   while(*str) {
      status_putc(*str++);
   }
}

uint8_t status_stream_buffer[2048];
uint16_t status_stream_ptr = 0;

void status_flush()
{
   uint16_t i;
   for(i = 0; i < status_stream_ptr; i++) {
      status_putc(status_stream_buffer[i]);
   }
   status_stream_ptr = 0;
}

void status_buffer(uint8_t c)
{
   if(status_stream_ptr == sizeof(status_stream_buffer)) {
      return;
   }
   status_stream_buffer[status_stream_ptr++] = c;
}

void status_printf(const char *Format, ...)
{
   int Len;
   int MaxLen = sizeof(status_stream_buffer) - status_stream_ptr;
   va_list Args;

   va_start(Args,Format);

   Len = vsnprintf((status_stream_buffer + status_stream_ptr),MaxLen,Format,Args);
   status_stream_ptr += Len;
}

