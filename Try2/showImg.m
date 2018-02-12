function[] = showImg(titleContents, img)
hAxes = axes( figure );
hImage = imshow( img, 'Parent', hAxes );
title( hAxes, titleContents);
end