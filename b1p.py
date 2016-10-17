import json

def isAttack(board,r,c):
	for i in range(r):
		if(board[i][c] == 1):# c is queen
			return True
	i=r-1
	j=c-1
	while((i>=0) and (j>=0)):
		if(board[i][j] == 1):
			return True
		i=i-1
		j=j-1
	i=r-1
	j=c+1
	while((i>=0) and (j<8)):
		if(board[i][j] == 1):
			return True
		i=i-1
		j=j+1
	return False

def solve(board,row):
	i=0
	while(i<8):
		if(not isAttack(board,row,i)): #i is queen
			board[row][i]=1
			if(row == 7):
				return True
			else:
				if(solve(board,row+1)):
					return True
				else:
					board[row][i]=0
		i=i+1
	if(i == 8):
		return False

board=[[0 for x in range(8)] for x in range(8)]
if __name__=='__main__':
	data=[]
	with open('input.json') as f:
		data=json.load(f)
	if(data["start"]<0 or data["start"]>8):
		print "Invalid"
		exit()
	board[0][data["start"]]=1
	if(solve(board,1)):
		print "Solved!"
		for i in range(8):
			for j in range(8):
				print str(board[i][j])+" ",
			print "\n"
	else:
		print "Can't solve!"
