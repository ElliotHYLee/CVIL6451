clc, clear, close all

cmd = char(strcat('cd', {' '}, pwd, '/python'))
out = system(cmd);
pwd
cmd = 'python python/NN_dicho.py 2';
out = system(cmd);




