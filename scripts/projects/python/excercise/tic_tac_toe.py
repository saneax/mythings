def draw_screen(d,p):
  if type(d) == list:
    print " ", p, " | ", 1, " | ", 2, " | ", 3, " "
    print "-----------------------"
    print "  1   | ",d[0][0]," | ", d[0][1], " | ",d[0][2], " "
    print "-----------------------"
    print "  2   | ",d[1][0]," | ", d[1][1], " | ",d[1][2], " "
    print "----------------------"
    print "  3   | ",d[2][0]," | ", d[2][1], " | ",d[2][2], " "
    print "                     "
    print " Select RC (Row, Column) without the coma, example 11, for row 1 and col 1 :"
  else:
    print "Passed Object is not supported, please pass a list"

def game_won(d):
  flag = False
  #draw_screen(d)
  for i in range (0,3):
    if d[i][0] == d[i][1] == d[i][2] != '-':
      flag = True
    if d[0][i] == d[1][i] == d[2][i] != '-':
      flag = True
  else:
    if d[0][0] == d[1][1] == d[2][2] != '-':
      flag = True
    if d[2][0] == d[1][1] == d[0][2] != '-':
      flag = True

  return flag


d = [['-','-','-'],['-','-','-'],['-','-','-']]
win=False
step = 0

while win == False:
  person = 'P1' if step%2==0 else 'P2'
  draw_screen(d,person)
  ch_flag=False
  cval=0
  rval=0
  step += 1
  while ch_flag == False:
    s = raw_input()
    rval = int(s[0])
    cval = int(s[1])
    if rval > 0 < cval and rval < 4 > cval:
      #empty cell
      if d[rval-1][cval-1] == '-':
        if step % 2 == 0:
          d[rval-1][cval-1] = 'o'
          if game_won(d) == True:
            print "Second person has won the game"
            win = True
            break
        else:
          d[rval-1][cval-1] = 'x'
          if game_won(d) == True:
            print "First person has won the game"
            win = True
            break
        ch_flag = True
        continue
      else:
        #not empty cell
        print "Choice error : The cell choosen ie row:",rval," and col:",cval, " are not empty"
        continue
    else:
      print "Choice Error : The cell choosen ie row:",rval," and col:",cval, " are outside the cordinates, they should be less than 4 and more than 3"
      continue

